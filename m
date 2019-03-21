Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE168C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F894218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arashfotouhi.com header.i=@arashfotouhi.com header.b="Gl08xGXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfCUTjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:39:24 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.154]:27759 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728013AbfCUTjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:39:20 -0400
X-Greylist: delayed 1248 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 15:39:20 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id C03EC401428D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:18:31 -0500 (CDT)
Received: from box5525.bluehost.com ([162.241.218.13])
        by cmsmtp with SMTP
        id 73Cxh3XX12PzO73CxhNmiX; Thu, 21 Mar 2019 14:18:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=arashfotouhi.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bXjtLnwcSJzQo4aUrP86WEA+tLC/C4TE8HfzIl/qxbU=; b=Gl08xGXbK//ZwgP88JqBBffcOj
        w9d98mqD51eWEyJB9cT7PUMKZMDsI1Qwfzs78iUiVGEfn7HABBZD68XfDrrxfiw/eYKgiX4SM697E
        Za/ai3py75l9few2kawIZ6W0nE2cb7DE6hc0vccj3kdbSGT2uqjCYt2eUhin+EIVvz/YynwIpw0Rb
        ZiBLL8pCuBZpqYE2FN5Gwc+/KEBEocGeoosv+kCyOSmVw/xOmXKqvue/UbEBdmbCK7+QmQ57VpdI3
        xJa8y+bRUx5MX2uy3mNeRe2DTKCa2xWFk8o2Wnj6B53G72pY+gRaFqVT5EhiJ+Mt2S0CwjtrWqyqM
        KR7V+hbQ==;
Received: from cpe-172-113-71-92.socal.res.rr.com ([172.113.71.92]:53031 helo=ubuntu.localdomain)
        by box5525.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.91)
        (envelope-from <arash@arashfotouhi.com>)
        id 1h73Cw-0010ih-Sc; Thu, 21 Mar 2019 14:18:30 -0500
From:   Arash Fotouhi <arash@arashfotouhi.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        olsonse@umich.edu, giulio.benetti@micronovasrl.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Arash Fotouhi <arash@arashfotouhi.com>
Subject: [PATCH] Staging: comedi: ni_mio_common.c: Added blank line after declarations
Date:   Thu, 21 Mar 2019 12:18:12 -0700
Message-Id: <1553195892-40323-1-git-send-email-arash@arashfotouhi.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5525.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arashfotouhi.com
X-BWhitelist: no
X-Source-IP: 172.113.71.92
X-Source-L: No
X-Exim-ID: 1h73Cw-0010ih-Sc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cpe-172-113-71-92.socal.res.rr.com (ubuntu.localdomain) [172.113.71.92]:53031
X-Source-Auth: arash@arashfotouhi.com
X-Email-Count: 2
X-Source-Cap: bXltaWNybzU7bXltaWNybzU7Ym94NTUyNS5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added blank line after declarations.

Signed-off-by: Arash Fotouhi <arash@arashfotouhi.com>
---
 drivers/staging/comedi/drivers/ni_mio_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
index 5edf59a..c6aff8f 100644
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -2110,6 +2110,7 @@ static int ni_ai_cmdtest(struct comedi_device *dev, struct comedi_subdevice *s,
 
 	if (cmd->scan_begin_src == TRIG_TIMER) {
 		unsigned int tmp = cmd->scan_begin_arg;
+
 		cmd->scan_begin_arg =
 		    ni_timer_to_ns(dev, ni_ns_to_timer(dev,
 						       cmd->scan_begin_arg,
@@ -2120,6 +2121,7 @@ static int ni_ai_cmdtest(struct comedi_device *dev, struct comedi_subdevice *s,
 	if (cmd->convert_src == TRIG_TIMER) {
 		if (!devpriv->is_611x && !devpriv->is_6143) {
 			unsigned int tmp = cmd->convert_arg;
+
 			cmd->convert_arg =
 			    ni_timer_to_ns(dev, ni_ns_to_timer(dev,
 							       cmd->convert_arg,
-- 
2.7.4

