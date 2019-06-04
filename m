Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261E3C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF4B23A79
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="HkxY5XCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfFDMxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:53:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:9789 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfFDMxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559652822;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=h/olzvx6AHUnjyG3bvwHdKbqZ3KevZuFbh4sUPMSXZI=;
        b=HkxY5XCcxl4WJ3omW+TloM7OlUqdDeTe09MkcNXB1xgEd9CrzeOYNDlueneZ/rnGoy
        VQsGMNgSipaR9QfYjUUinenhamFqQ5qtbBIl0uqp4dB7OkuWmQvH7Q/C8qTbt/lCKLZg
        CEjg1Szo75994DbHtCYUfPbjOBJH9Se/fhw99J4ExEJ55gEuijMUbDN1vhUACvc6bpWK
        JuohfoPkzpNDav8RJj/vWtUWDSdJOUOlIyxjHbuvDBYBkiN/+IjYMtNsTY/IPTSKVMBf
        PbGCqBrutXIgqJU/JXd2xFafVNpDXyYlzMiO2RC+YQ2JqbQOKkPkzG5EZU1QkpnDnp9I
        tpNA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0pAzTh/eDM="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.22 DYNA|AUTH)
        with ESMTPSA id i01b98v54CrZ7YA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 4 Jun 2019 14:53:35 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com,
        marek.belisko@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/2] drm/panel-simple: Add panel parameters for ortustech-com37h3m05dtc/99dtc and sharp-lq070y3dg3b
Date:   Tue,  4 Jun 2019 14:53:32 +0200
Message-Id: <cover.1559652814.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since v5.2-rc1 OMAP is no longer using a special display driver architecture
for DPI panels, but uses the general drm/panel/panel-simple.

So we finally can add SoC independent panel definitions for two panel models
which we already had worked on quite a while ago (before device tree was
introduced):

	https://patchwork.kernel.org/patch/2851295/



H. Nikolaus Schaller (2):
  drm/panel: simple: Add Sharp LQ070Y3DG3B panel support
  drm/panel: simple: Add Ortustech COM37H3M panel support

 drivers/gpu/drm/panel/panel-simple.c | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

-- 
2.19.1

