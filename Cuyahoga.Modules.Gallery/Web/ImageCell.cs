#region Copyright and License
/*
Copyright 2006 Dominique Paris, xp-rience.net
Design work copyright Dominique Paris (http://www.xp-rience.net/)

You can use this Software for any commercial or noncommercial purpose, 
including distributing derivative works.

In return, we simply require that you agree:

1. Not to remove any copyright notices from the Software. 
2. That if you distribute the Software in source code form you do so only 
   under this License (i.e. you must include a complete copy of this License 
   with your distribution), and if you distribute the Software solely in 
   object form you only do so under a license that complies with this License. 
3. That the Software comes "as is", with no warranties. None whatsoever. This 
   means no express, implied or statutory warranty, including without 
   limitation, warranties of merchantability or fitness for a particular 
   purpose or any warranty of noninfringement. Also, you must pass this 
   disclaimer on whenever you distribute the Software.
4. That if you sue anyone over patents that you think may apply to the 
   Software for a person's use of the Software, your license to the Software 
   ends automatically. 
5. That the patent rights, if any, licensed hereunder only apply to the 
   Software, not to any derivative works you make. 
6. That your rights under this License end automatically if you breach it in 
   any way.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/
#endregion
using System;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

using Cuyahoga.Modules.Gallery.Domain;

namespace Cuyahoga.Modules.Gallery.Web
{
	/// <summary>
	/// xpImage defines all the elements of an image to be rendered
	/// </summary>
	public class ImageCell : System.Web.UI.HtmlControls.HtmlTableCell
	{
		
		// private HtmlGenericControl _container;

		public string CssClass
		{
			get { return base.Attributes[ "Class" ]; }
			set 
			{
				if ( base.Attributes[ "class" ] != null ) 
					base.Attributes[ "class" ] = value;
				else
					base.Attributes.Add( "class", value );
			}
		}

		public ImageCell():base() 
		{	
			// _container = new HtmlGenericControl("div");
		}

		public void AddImage( HtmlImage image )
		{
			this.AddControlToBase( image );
		}
		
		public void AddBreak()
		{
			Literal c = new Literal();
			c.Text = "<br>";
			this.AddControlToBase( c );
		}

		public void AddText( string text )
		{
			this.AddText( text, null );
		}

		public void AddText( string text , string cssClass )
		{
			HtmlGenericControl c = new HtmlGenericControl();
			c.TagName = "span";
			c.InnerText = text;
			if ( cssClass != null && cssClass != String.Empty ) c.Attributes.Add( "class", cssClass );
			this.AddControlToBase( c );
		}

		public void AddControl( System.Web.UI.Control control )
		{
			this.AddControlToBase( control );
		}

		private void AddControlToBase( System.Web.UI.Control control )
		{
			//_container.Controls.Add( control );
			base.Controls.Add( control );
		}

		public void save()
		{
//			base.Controls.Add( _container);
//			_container = new HtmlGenericControl("div");
		}
	}
}
