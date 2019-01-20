module HomeHelper

    def active_link_if_active(href, title)
        if (request.path == href)

            out = "<li class=\"nav-item active\">"
                out += "<a class=\"nav-link\" href=\"" + href + "\">" + title + "<span class=\"sr-only\">(current)</span></a>"
        else
            out = "<li class=\"nav-item\">"
                out += "<a class=\"nav-link\" href=\"" + href + "\">" + title + "<span class=\"sr-only\"></span></a>"
        end
        out += "</li>"
        return out.html_safe
    end

end
