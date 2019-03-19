Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614F9C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A362075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JqPS57lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfCSQw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:52:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:33455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCSQwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553014353;
        bh=DqiIl/LdOxGWRlLxqdmdgJ/hwY3i58tuTNHAaFlgsVE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JqPS57lkLHgMXw2JK3iEzipGEtj1WNOiAIPSx+tGHC+1X7vJ2O8bkEuL4VoYoXKHy
         KahQkfxByVckjYUiBwlcsMSzRgHKZ2IoAdMcrvt8Lc2+asn5ajI9nUIsW1dbV3Y9+H
         nHtjLfPvKrOcgJ/HdOX5nKIKT2VHY6MsTOyMka0s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [93.201.42.96] ([93.201.42.96]) by web-mail.gmx.net
 (3c-app-gmx-bs54.server.lan [172.19.170.138]) (via HTTP); Tue, 19 Mar 2019
 17:52:32 +0100
MIME-Version: 1.0
Message-ID: <trinity-2a241119-4398-49c4-bcb6-177d13530d31-1553014352943@3c-app-gmx-bs54>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "CK Hu" <ck.hu@mediatek.com>
Cc:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        srv_heupstream@mediatek.com, "David Airlie" <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?=22Noralf_Tr=EF=BF=BDnnes=22?= <noralf@tronnes.org>,
        linux-mediatek@lists.infradead.org,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re:  Re:  [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer
 device
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 19 Mar 2019 17:52:32 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <1552965129.7881.5.camel@mtksdaap41>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
 <20190116013924.11345-2-ck.hu@mediatek.com>
 <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
 <1547775975.4221.11.camel@mtksdaap41>
 <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
 <trinity-1c369adc-b489-43dd-87c9-5b43d49561c5-1547991406711@3c-app-gmx-bs40>
 <1552965129.7881.5.camel@mtksdaap41>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:8XPNGexNPc1QdQhLTIGeEiQce2O1bCcqVPxNcxXagkUvmASK5Oiw6dTFPtfh7QYAu8uAa
 qfsHyqCx4iur/eT09D0hBEZ3Aw7dxafILdrijRWKH9Ui2+dl/lLym76zitAIOGs0vk4SycjPFVN+
 ool1N1yvIXSsAeAu+RzVkONmAAdE8Xx7Odyw1GyWA8h2jfiodoBvNsel/XBZXielriSHUW2pxEfz
 kvnN5A9weufmMoasXxKf6whIZK4BNTNgoxC+n6cm6TNCReOSKEAqZsxVUn2tpNRS691u3sTqtdGQ
 rU=
X-UI-Out-Filterresults: notjunk:1;V03:K0:oskGQDYt2P8=:2SCp/GoCTN4c8kPdji8v6U
 ekSN4kWfPj+hCHSAkgiyESghTg0EHevJC+88wpBqNRC4cSpCos6Mfw4fswnZUJZ/CDSccaXNI
 oAJQ7xLlXLw3/PjVNMb+OankEdzlq86gyQm6jgMhlgEiMi94Wuz7P7Cc/HtvQGTJsLkJvTKc7
 55W8fC/lYv18XA8v3qKOJDqS9OTNEjoBOuSa91kVhGNNSkP6FQKcuRNVF/6WOq/MV4MNdiS7c
 0G11nwmQP+NCktVcdkSo+kShCVlreTHLdjm9zHrDQi9nrNzfQePAUvy8zGbt/MTOce1RiqH6z
 Ta3I44plGcusTFiXZd4uNJGN9Ihv51egmkK09ZQnD/A5B7WXe08d8nE76qrcspKTuslsSHTnH
 hAaAn+o2eRb2HuaQAHDiIAu4hmNbK+GyHbgYj0/rASlosIvl0AUTL8oLQ72juB6p8PMVi7rFG
 2S2XLlZRFETop2PBaJQ3rHI1nvK/qCAOaqVD4uy2s9m9cG5FHoSk68OQFLaJtEVl8W+xNSxO2
 8GsYf4z/K8uErYHo7O+6TfdqpOYZ4pj34t3ZHIdUJO3G5xuAwPv/pcWPA6oXhlJiyhw1tHBN1
 AKU6tQlDLn3I0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i try to get hdmi running on bananapi-r2 with 5.1 but also without CK Hu's frambuffer-Patch i get no x-server working

my codebase: https://github.com/frank-w/BPI-R2-4.14/commits/5.1-hdmi
reused some Patches working on 5.0 (here X-server is working, but not fbcon)

WARNING: CPU: 2 PID: 895 at drivers/gpu/drm/drm_atomic_helper.c:1430 drm_atomic_helper_wait_for_vblanks.part.1+0x2a4/0x2a8

any hint how to fix this? if needed i can send full bootlog (with drm.debug=7)

regards Frank
