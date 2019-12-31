Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1649C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5C5206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vnBD1qz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLaLNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 06:13:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59722 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfLaLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 06:13:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVBDgWY114782;
        Tue, 31 Dec 2019 05:13:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577790822;
        bh=qYB3z4BIBCUTy/5rxLIcscJ5qRoXJ0wRgvPpS0tdPPg=;
        h=From:To:CC:Subject:Date;
        b=vnBD1qz6YyFxBdsJ7okDt43FjPIRKKrbHQcubUjh7xr3rlw1lVwPcXplRkHsmKK91
         RJxJH8n35WQlnu8rSwEa3Hg+S8mx2uBlVvGZExoWJIqJyG/tREUw04W6zaoK2IYiy8
         eg2gxn1m2Fv7jknvOhr6NylzTka9Xk378ng15670=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVBDgai012808
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 05:13:42 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 05:13:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 05:13:42 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBDeT4011884;
        Tue, 31 Dec 2019 05:13:40 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: for 5.5 -rc
Date:   Tue, 31 Dec 2019 16:45:41 +0530
Message-ID: <20191231111541.29702-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.5 -rc cycle.

It includes a bunch of bug fixes for cpcap-usb PHY driver which is used
for configuring USB PHY and debug UART used in certain Motorola droid4
phones. It also includes a minor fix in qcom-qmp PHY driver and
rockchip-inno-hdmi causing a display issue in RK3328.

Please see the tag message below for the complete list of changes and
let me know If I have to change something.

Thanks
Kishon

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.5-rc

for you to fetch changes up to 4f510aa10468954b1da4e94689c38ac6ea8d3627:

  phy/rockchip: inno-hdmi: round clock rate down to closest 1000 Hz (2019-12-31 15:46:08 +0530)

----------------------------------------------------------------
phy: for 5.5-rc

*) Fix error path in cpcap-usb driver when no host driver is loaded to
   avoid debug serial console from stop working
*) Fix to let USB host idle before switching to UART mode in cpcap-usb
   driver in order to avoid flakey enumeration next time
*) Prevent USB line glitches from waking up modem by enabling the USB
   lines (GPIO mux) after configuring the cpcap-usb PHY
*) Improve host vs docked mode detection in cpcap-usb PHY driver to keep
   VBUS enabled in host mode
*) Fix to prevent cpcap-usb PHY driver from enabling the PHY twice
*) Increase PHY ready timeout in qcom-qmp PHY as it takes more than 1ms
   to initialize
*) Round clock rate down to closest 1000 Hz in phy-rockchip-inno-hdmi to
   prevent wrong pixel clock to be used and result in no-signal when
   configuring a mode on RK3328

----------------------------------------------------------------
Bjorn Andersson (1):
      phy: qcom-qmp: Increase PHY ready timeout

Jonas Karlman (1):
      phy/rockchip: inno-hdmi: round clock rate down to closest 1000 Hz

Tony Lindgren (6):
      phy: cpcap-usb: Fix error path when no host driver is loaded
      phy: cpcap-usb: Fix flakey host idling and enumerating of devices
      phy: mapphone-mdm6600: Fix uninitialized status value regression
      phy: cpcap-usb: Prevent USB line glitches from waking up modem
      phy: cpcap-usb: Improve host vs docked mode detection
      phy: cpcap-usb: Drop extra write to usb2 register

 drivers/phy/motorola/phy-cpcap-usb.c          | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
 drivers/phy/motorola/phy-mapphone-mdm6600.c   |  11 +++--------
 drivers/phy/qualcomm/phy-qcom-qmp.c           |   2 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c |   4 ++++
 4 files changed, 98 insertions(+), 47 deletions(-)
-- 
2.17.1

