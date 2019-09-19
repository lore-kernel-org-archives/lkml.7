Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E93C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3C218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930725;
	bh=EJP4nNfG7YbTybV+6Scm3vb4nnLKhgmOruTce9/Yr4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HNcz2YDyH2HNSrCSYnqbk5qtbP5gJWmJTcey+VgAA1QJ7jE/rRhdWR7Z52FX2icGm
	 qj8TenVJCRTYjnTSDpFiv34G1S91PySBfWSrzOE1stBCAgT47N150y5tFUAP/icpkn
	 4TdDtGPdv4X8bctectp7tRNdq52mzUtpQMbr/MJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404971AbfISWFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404932AbfISWFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:05:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA56218AF;
        Thu, 19 Sep 2019 22:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930722;
        bh=EJP4nNfG7YbTybV+6Scm3vb4nnLKhgmOruTce9/Yr4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDIixJiHM31ukA+wo+eUpub3U4tV9xSFK2k3oJDL8y06t6CCXBANv/FqPLCn2l2vw
         QRMqaDmVyd10Rn/pJVcsT4PSR5WaKamFI0GPC5AsZaqEONHZ8t33p0rKtfUKQQ3MaR
         RJYk0D4PVCjZ/risqkwiyYa2Z1JKGgtlPKgaBNeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5.3 12/21] Documentation: sphinx: Add missing comma to list of strings
Date:   Fri, 20 Sep 2019 00:03:13 +0200
Message-Id: <20190919214706.339764323@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214657.842130855@linuxfoundation.org>
References: <20190919214657.842130855@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

commit 11fec009d97e5bd2329ef7d52d71e9f6763f1048 upstream.

In Python, like in C, when a comma is omitted in a list of strings, the
two strings around the missing comma are concatenated.

Cc: stable@vger.kernel.org  # v5.2 only
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/sphinx/automarkup.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -25,7 +25,7 @@ RE_function = re.compile(r'([\w_][\w\d_]
 # to the creation of incorrect and confusing cross references.  So
 # just don't even try with these names.
 #
-Skipfuncs = [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap'
+Skipfuncs = [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap',
               'select', 'poll', 'fork', 'execve', 'clone', 'ioctl']
 
 #


