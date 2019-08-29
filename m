Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03504C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59852073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfH2HXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:23:01 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58356 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfH2HXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:23:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 787F0FB03;
        Thu, 29 Aug 2019 09:22:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KtmbkXjx-TTe; Thu, 29 Aug 2019 09:22:54 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9278742EEE; Thu, 29 Aug 2019 09:22:53 +0200 (CEST)
Date:   Thu, 29 Aug 2019 09:22:53 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [EXT] [PATCH v3 0/2] drm: bridge: Add NWL MIPI DSI host
 controller support
Message-ID: <20190829072253.GA5078@bogon.m.sigxcpu.org>
References: <cover.1566470526.git.agx@sigxcpu.org>
 <1567002587.3209.122.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567002587.3209.122.camel@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Aug 28, 2019 at 02:29:48PM +0000, Robert Chiras wrote:
> Hi Guido,
> 
> I tested this on my setup and it works. My DSI panel is a little bit
> different and it doesn't work with this as-is, but I added some
> improvements on top of this, in order to be able to setup the clocks.
> The changes I made can arrive on top of this as improvements, of
> course, since it will allow this driver to dinamically set the
> video_pll clock for any kind of mode.
> 
> So, for the whole patch-set, you can add:
> Tested-by: Robert Chiras <robert.chiras@nxp.com>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>

Added for v4, thanks!
 -- Guido

> 
> Best regards,
> Robert
> 
> On Jo, 2019-08-22 at 12:44 +0200, Guido Günther wrote:
> > This adds initial support for the NWL MIPI DSI Host controller found
> > on i.MX8
> > SoCs.
> > 
> > It adds support for the i.MX8MQ but the same IP core can also be
> > found on e.g.
> > i.MX8QXP. I added the necessary hooks to support other imx8 variants
> > but since
> > I only have imx8mq boards to test I omitted the platform data for
> > other SoCs.
> > 
> > The code is based on NXPs BSP so I added Robert Chiras as
> > Co-authored-by. Robert, if this looks sane could you add your
> > Signed-off-by:?
> > 
> > The most notable changes over the BSP driver are
> >  - Calculate HS mode timing from phy_configure_opts_mipi_dphy
> >  - Perform all clock setup via DT
> >  - Merge nwl-imx and nwl drivers
> >  - Add B0 silion revision quirk
> >  - become a bridge driver to hook into mxsfb (from what I read[0]
> > DCSS, which
> >    also can drive the nwl on the imx8mq will likely not become part
> > of
> >    imx-display-subsystem so it makes sense to make it drive a bridge
> > for dsi as
> >    well).
> >  - Use panel_bridge to attach the panel
> >  - Use multiplex framework instead of accessing syscon directly
> > 
> > This has been tested on a Librem 5 devkit using mxsfb with Robert's
> > patches[1]
> > and the rocktech-jh057n00900 panel driver on next-20190821. The DCSS
> > can later
> > on also act as input source too.
> > 
> > Changes from v2:
> > - Per review comments by Rob Herring
> >   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> > ists.freedesktop.org%2Farchives%2Fdri-devel%2F2019-
> > August%2F230448.html&amp;data=02%7C01%7Crobert.chiras%40nxp.com%7C757
> > 201f9aaa54653580e08d726edb290%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > 7C0%7C637020674654566414&amp;sdata=JdvAdCPGq2CTsW%2BgXgnAVltWMIfdCDQn
> > dXSLYpnjEH8%3D&amp;reserved=0
> >   - bindings:
> >     - Simplify by restricting to fsl,imx8mq-nwl-dsi
> >     - document reset lines
> >     - add port@{0,1}
> >     - use a real compatible string for the panel
> >     - resets are required
> > - Per review comments by Arnd Bergmann
> >   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> > ists.freedesktop.org%2Farchives%2Fdri-devel%2F2019-
> > August%2F230868.html&amp;data=02%7C01%7Crobert.chiras%40nxp.com%7C757
> > 201f9aaa54653580e08d726edb290%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > 7C0%7C637020674654566414&amp;sdata=LyJpZjQjMCe5zUdvK8CD8ETucLPxx621gW
> > xtpAr8DM4%3D&amp;reserved=0
> >   - Don't access iomuxc_gpr regs directly. This allows us to drop the
> >     first patch in the series with the iomuxc_gpr field defines.
> > - Per review comments by Laurent Pinchart
> >     - Fix wording in bindings
> > - Add mux-controls to bindings
> > - Don't print error message on dphy probe deferal
> > 
> > Changes from v1:
> > - Per review comments by Sam Ravnborg
> >   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> > ists.freedesktop.org%2Farchives%2Fdri-devel%2F2019-
> > July%2F228130.html&amp;data=02%7C01%7Crobert.chiras%40nxp.com%7C75720
> > 1f9aaa54653580e08d726edb290%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> > 0%7C637020674654566414&amp;sdata=AU2gzIwrbCdIBZenPWWYYX%2BgdX53zc2%2B
> > SQhZbuN%2FWpU%3D&amp;reserved=0
> >   - Change binding docs to YAML
> >   - build: Don't always visit imx-nwl/
> >   - build: Add header-test-y
> >   - Sort headers according to DRM convention
> >   - Use drm_display_mode instead of videmode
> > - Per review comments by Fabio Estevam
> >   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> > ists.freedesktop.org%2Farchives%2Fdri-devel%2F2019-
> > July%2F228299.html&amp;data=02%7C01%7Crobert.chiras%40nxp.com%7C75720
> > 1f9aaa54653580e08d726edb290%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> > 0%7C637020674654566414&amp;sdata=6kpIZ6iNAQ13fMXU6sqENLwy%2FdIWL6ef8j
> > gyas7I0CQ%3D&amp;reserved=0
> >   - Don't restrict build to ARCH_MXC
> >   - Drop unused includes
> >   - Drop unreachable code in imx_nwl_dsi_bridge_mode_fixup()
> >   - Drop remaining calls of dev_err() and use DRM_DEV_ERR()
> >     consistently.
> >   - Use devm_platform_ioremap_resource()
> >   - Drop devm_free_irq() in probe() error path
> >   - Use single line comments where sufficient
> >   - Use <linux/time64.h> instead of defining USEC_PER_SEC
> >   - Make input source select imx8 specific
> >   - Drop <asm/unaligned.h> inclusion (after removal of
> > get_unaligned_le32)
> >   - Drop all EXPORT_SYMBOL_GPL() for functions used in the same
> > module
> >     but different source files.
> >   - Drop nwl_dsi_enable_{rx,tx}_clock() by invoking
> > clk_prepare_enable()
> >     directly
> >   - Remove pointless comment
> > - Laurent Pinchart
> >   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> > ists.freedesktop.org%2Farchives%2Fdri-devel%2F2019-
> > July%2F228313.html&amp;data=02%7C01%7Crobert.chiras%40nxp.com%7C75720
> > 1f9aaa54653580e08d726edb290%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> > 0%7C637020674654566414&amp;sdata=tDlVGeET1CPMH9W%2FqmnePNR51vNaTKD%2F
> > iFOoR9%2FmESc%3D&amp;reserved=0
> >   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> > ists.freedesktop.org%2Farchives%2Fdri-devel%2F2019-
> > July%2F228308.html&amp;data=02%7C01%7Crobert.chiras%40nxp.com%7C75720
> > 1f9aaa54653580e08d726edb290%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> > 0%7C637020674654566414&amp;sdata=NsLGAL8%2BcOC0ZZxxeoGe7VxQCgqSBEN4G3
> > WVGOeZpCo%3D&amp;reserved=0
> >   - Drop (on iMX8MQ) unused csr regmap
> >   - Use NWL_MAX_PLATFORM_CLOCKS everywhere
> >   - Drop get_unaligned_le32() usage
> >   - remove duplicate 'for the' in binding docs
> >   - Don't include unused <linux/clk-provider.h>
> >   - Don't include unused <linux/component.h>
> >   - Drop dpms_mode for tracking state, trust the drm layer on that
> >   - Use pm_runtime_put() instead of pm_runtime_put_sync()
> >   - Don't overwrite encoder type
> >   - Make imx_nwl_platform_data const
> >   - Use the reset controller API instead of open coding that platform
> > specific
> >     part
> >   - Use <linux/bitfield.h> intead of making up our own defines
> >   - name mipi_dsi_transfer less generic: nwl_dsi_transfer
> >   - ensure clean in .remove by calling mipi_dsi_host_unregister.
> >   - prefix constants by NWL_DSI_
> >   - properly format transfer_direction enum
> >   - simplify platform clock handling
> >   - Don't modify state in mode_fixup() and use mode_set() instead
> >   - Drop bridge detach(), already handle by nwl_dsi_host_detach()
> >   - Drop USE_*_QUIRK() macros
> > - Drop (for now) unused clock defnitions. 'pixel' and 'bypass' clock
> > will be
> >   used for i.MX8 SoCs but since they're unused atm drop the
> > definitions - but
> >   keep the logic to enable/disable several clocks in place since we
> > know we'll
> >   need it in the future.
> > 
> > Changes from v0:
> > - Add quirk for IMQ8MQ silicon B0 revision to not mess with the
> >   system reset controller on power down since enable() won't work
> >   otherwise.
> > - Drop devm_free_irq() handled by the device driver core
> > - Disable tx esc clock after the phy power down to unbreak
> >   disable/enable (unblank/blank)
> > - Add ports to dt binding docs
> > - Select GENERIC_PHY_MIPI_DPHY instead of GENERIC_PHY for
> >   phy_mipi_dphy_get_default_config
> > - Select DRM_MIPI_DSI
> > - Include drm_print.h to fix build on next-20190408
> > - Drop some debugging messages
> > - Newline terminate all DRM_ printouts
> > - Turn component driver into a drm bridge
> > 
> > [0]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%
> > 2Flists.freedesktop.org%2Farchives%2Fdri-devel%2F2019-
> > May%2F219484.html&amp;data=02%7C01%7Crobert.chiras%40nxp.com%7C757201
> > f9aaa54653580e08d726edb290%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C637020674654566414&amp;sdata=4IVjhLy3a2XxZ4jYwDFD23D%2BvwAVAEj44hY
> > fvvp8OpQ%3D&amp;reserved=0
> > [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%
> > 2Fpatchwork.freedesktop.org%2Fseries%2F62822%2F&amp;data=02%7C01%7Cro
> > bert.chiras%40nxp.com%7C757201f9aaa54653580e08d726edb290%7C686ea1d3bc
> > 2b4c6fa92cd99c5c301635%7C0%7C0%7C637020674654566414&amp;sdata=GueUBOc
> > baGjWtWcMYBplL6ki2UbgaFPkQHg%2F6eReiYg%3D&amp;reserved=0
> > 
> > To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
> > Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
> > , Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.
> > de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <
> > festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Andrzej
> > Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>
> > , Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
> > <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@siol.net>, Lee
> > Jones <lee.jones@linaro.org>, Guido Günther <agx@sigxcpu.org>, dri-de
> > vel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kern
> > el@lists.infradead.org, linux-kernel@vger.kernel.org, Robert Chiras <
> > robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, Fabio
> > Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>
> > 
> > 
> > Guido Günther (2):
> >   dt-bindings: display/bridge: Add binding for NWL mipi dsi host
> >     controller
> >   drm/bridge: Add NWL MIPI DSI host controller support
> > 
> >  .../bindings/display/bridge/nwl-dsi.yaml      | 155 ++++
> >  drivers/gpu/drm/bridge/Kconfig                |   2 +
> >  drivers/gpu/drm/bridge/Makefile               |   1 +
> >  drivers/gpu/drm/bridge/nwl-dsi/Kconfig        |  16 +
> >  drivers/gpu/drm/bridge/nwl-dsi/Makefile       |   4 +
> >  drivers/gpu/drm/bridge/nwl-dsi/nwl-drv.c      | 501 +++++++++++++
> >  drivers/gpu/drm/bridge/nwl-dsi/nwl-drv.h      |  65 ++
> >  drivers/gpu/drm/bridge/nwl-dsi/nwl-dsi.c      | 700
> > ++++++++++++++++++
> >  drivers/gpu/drm/bridge/nwl-dsi/nwl-dsi.h      | 112 +++
> >  9 files changed, 1556 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/Kconfig
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/Makefile
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/nwl-drv.c
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/nwl-drv.h
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/nwl-dsi.c
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/nwl-dsi.h
> > 
> > --
> > 2.20.1
> > 
