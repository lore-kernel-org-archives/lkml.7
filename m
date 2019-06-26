Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48779C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFF6208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="pN3YcaFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfFZHed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:34:33 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:57509 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfFZHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:34:32 -0400
Received: from mx-exchlnx-1.rrze.uni-erlangen.de (mx-exchlnx-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::37])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZY26x6kz8tkh;
        Wed, 26 Jun 2019 09:34:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561534470; bh=+trvo7ZSF3U/17+gZAtpWt3iDQQ73VJ772AhC/qoCuI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=pN3YcaFyl+jHd9qd96MKzlI/2xznxO/m0PJ+3Hu9cpIUZmfqiocTen92FepwGIv7t
         SHaQprJgdsmA++w9SbGg789XfNcEJAo0oAQloD6bp8l4lB/VQILCk4R3475LdGpowx
         L5R7AgzGQ3zLfuDvK7y5zgOxaCmvjdxOjvMg9JLe+yYZmmx29dwUTgYFgOYK3X+hI+
         /wg3fd6FwzVr10hnPLdl2295bDMFOU4YxYRr4+rQfTZwG0M917GFOp97VBs+N7HD+5
         8taIDl1sjqURQQvDcOgvYklECb6KSMfN8M0tmKQ/shY/xaMpHn4qJdzc7igIbjYzCM
         zGsTibnFxRAUg==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZY00fK3z8t4h;
        Wed, 26 Jun 2019 09:34:28 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun 2019
 09:34:17 +0200
Received: from TroubleWorld.fritz.box (95.90.221.207) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 26 Jun 2019 09:34:17 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] staging: kpc2000: style refactoring 
Date:   Wed, 26 Jun 2019 09:35:18 +0200
Message-ID: <20190626073531.8946-1-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625115251.GA28859@kadam>
References: <20190625115251.GA28859@kadam>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.90.221.207]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch-series that will remove warnings, errors and check-messages,
noted and highlighted by the checkpatch.pl script concerning
kpc2000_spi.c.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>

Fabian Krueger (8):
  staging: kpc2000: add line breaks
  staging: kpc2000: blank lines after declaration
  staging: kpc2000: introduce usage of __packed
  staging: kpc2000: remove unnecessary brackets
  staging: kpc2000: add spaces
  staging: kpc2000: introduce 'unsigned int'
  staging: kpc2000: introduce __func__
  staging: kpc2000: remove needless 'break'

 drivers/staging/kpc2000/kpc2000_spi.c | 99 ++++++++++++++-------------
 1 file changed, 51 insertions(+), 48 deletions(-)

-- 
2.17.1

