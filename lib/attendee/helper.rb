# encoding: utf-8

#  LINGO ist ein Indexierungssystem mit Grundformreduktion, Kompositumzerlegung,
#  Mehrworterkennung und Relationierung.
#
#  Copyright (C) 2005-2007 John Vorhauer
#  Copyright (C) 2007-2011 John Vorhauer, Jens Wille
#
#  This program is free software; you can redistribute it and/or modify it under
#  the terms of the GNU Affero General Public License as published by the Free
#  Software Foundation; either version 3 of the License, or (at your option)
#  any later version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
#  details.
#
#  You should have received a copy of the GNU Affero General Public License along
#  with this program; if not, write to the Free Software Foundation, Inc.,
#  51 Franklin St, Fifth Floor, Boston, MA 02110, USA
#
#  For more information visit http://www.lex-lingo.de or contact me at
#  welcomeATlex-lingoDOTde near 50°55'N+6°55'E.
#
#  Lex Lingo rules from here on


=begin rdoc
== Helper
Der Helper hilft bei automatischen Testreihen vor Releasefreigabe von Lingo. 
Für den praktischen Einsatz ist er nicht vorgesehen.
=end


class Attendee::Helper < Attendee

protected

  def init
    case
      when has_key?('spool_from')
        @spool_from = get_key('spool_from')
        @spooler = true
      when has_key?('dump_to')
        @dump_to = get_key('dump_to')
        @spooler = false
      else
        forward(STR_CMD_ERR, 'Weder dump_to noch spool_from-Attribut abgegeben')
    end
  end

  
  def control(cmd, param)
    if @spooler
      @spool_from.each { |obj| forward(obj) } if cmd==STR_CMD_TALK
    else
      @dump_to << AgendaItem.new(cmd, param)
    end
  end


  def process(obj)
    @dump_to << obj unless @spooler
  end
  
end
