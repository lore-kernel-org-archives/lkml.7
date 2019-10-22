Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD1C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759072089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbfJVIpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:45:21 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34128 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbfJVIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:45:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 37CFAFB03;
        Tue, 22 Oct 2019 10:45:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J_7FrQl3FDaI; Tue, 22 Oct 2019 10:45:15 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1D2F949BFC; Tue, 22 Oct 2019 10:45:15 +0200 (CEST)
Date:   Tue, 22 Oct 2019 10:45:14 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v7 2/2] drm/bridge: Add NWL MIPI DSI host controller
 support
Message-ID: <20191022084514.GA30274@bogon.m.sigxcpu.org>
References: <e0304ab9320cbbf3e63d78449e50975c036b2633.1571494140.git.agx@sigxcpu.org>
 <201910211901.yB3b4mYu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910211901.yB3b4mYu%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Oct 21, 2019 at 07:11:12PM +0800, kbuild test robot wrote:
> Hi "Guido,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.4-rc4 next-20191018]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see
> https://stackoverflow.com/a/37406982]

The base for this series is next-20191018 where drm_panel_bridge_add()
list it's second argument (89958b7cd9555a5d82556cc9a1f4c62fffda6f96).

Cheers,
 -- Guido

> 
> url:    https://github.com/0day-ci/linux/commits/Guido-G-nther/dt-bindings-display-bridge-Add-binding-for-NWL-mipi-dsi-host-controller/20191021-180825
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7d194c2100ad2a6dded545887d02754948ca5241
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/gpu/drm/bridge/nwl-dsi.c: In function 'nwl_dsi_host_attach':
> >> drivers/gpu/drm/bridge/nwl-dsi.c:384:12: error: too few arguments to function 'drm_panel_bridge_add'
>       bridge = drm_panel_bridge_add(panel);
>                ^~~~~~~~~~~~~~~~~~~~
>    In file included from include/drm/drm_crtc.h:44:0,
>                     from include/drm/drm_atomic_helper.h:31,
>                     from drivers/gpu/drm/bridge/nwl-dsi.c:24:
>    include/drm/drm_bridge.h:432:20: note: declared here
>     struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
>                        ^~~~~~~~~~~~~~~~~~~~
> 
> vim +/drm_panel_bridge_add +384 drivers/gpu/drm/bridge/nwl-dsi.c
> 
>    358	
>    359	static int nwl_dsi_host_attach(struct mipi_dsi_host *dsi_host,
>    360				       struct mipi_dsi_device *device)
>    361	{
>    362		struct nwl_dsi *dsi = container_of(dsi_host, struct nwl_dsi, dsi_host);
>    363		struct device *dev = dsi->dev;
>    364		struct drm_bridge *bridge;
>    365		struct drm_panel *panel;
>    366		int ret;
>    367	
>    368		DRM_DEV_INFO(dev, "lanes=%u, format=0x%x flags=0x%lx\n", device->lanes,
>    369			     device->format, device->mode_flags);
>    370	
>    371		if (device->lanes < 1 || device->lanes > 4)
>    372			return -EINVAL;
>    373	
>    374		dsi->lanes = device->lanes;
>    375		dsi->format = device->format;
>    376		dsi->dsi_mode_flags = device->mode_flags;
>    377	
>    378		ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
>    379						  &bridge);
>    380		if (ret)
>    381			return ret;
>    382	
>    383		if (panel) {
>  > 384			bridge = drm_panel_bridge_add(panel);
>    385			if (IS_ERR(bridge))
>    386				return PTR_ERR(bridge);
>    387		}
>    388	
>    389		dsi->panel_bridge = bridge;
>    390		drm_bridge_add(&dsi->bridge);
>    391	
>    392		return 0;
>    393	}
>    394	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

