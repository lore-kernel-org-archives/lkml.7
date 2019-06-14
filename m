Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3FAC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D032421537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477896;
	bh=ieyf6j9u1LImG2Kg4jfWRdvKu3h1T8XiHjBJFdFThIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+whHFvO0bYHdWH0zsq/2mnh0DtyuMSLBHU7Ia5XK42Op/3/z2qRT2Sq/UdKFuPo5
	 dQn5GYhSxnoCbPr0OMFEcyUDmiH5oU8omlP0l/14zjkzGkK4Tfjqcn0G/mF5+d34e6
	 l/sG1XuwUnArBON2XogD+X74/PbBsXCarmZGLjNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfFNCEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:04:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sRphWf8wFg3Yvz/q3q+E6FqyD8PeHYGCjmt44FlP/mI=; b=lkUwVoSRg0rRp+EjlDAkEqfudI
        U7lz+B37PkVdI5wrJP2ajKMeG8cKVs0Qw9aEGlg0Vj9i06GKwCjtX2cQA9gqzVbhc7lbvy5ArcA8V
        CnMfVDfHHJn6lkMNSYLY/hdVlssm0zwxRPcZgMiKzdKSTKxiUhUW2R8ohE2yNDxnTPggvprDK7MvO
        g3MQC932BkdwMu82msYkdXEel5GmhnrbXnzxFH7GAlCOwAY5MIk+31jUUJbxZfpeZyeYLsnAc9tqH
        u/dIsbRnLKJ/3fbG4iM3MxepxKMlEu6TQYqta2QrjHCKBs0wtuOibpEK8Epv4apRoiY1c/R2zAtKZ
        0x3RSpyw==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZr-0000E7-Ej; Fri, 14 Jun 2019 02:04:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002ng-Od; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 03/14] ABI: sysfs-class-uwb_rc: remove a duplicated incomplete entry
Date:   Thu, 13 Jun 2019 23:04:09 -0300
Message-Id: <f3646db9fa30c68a53b9990abe1d49fc2c83262b.1560477540.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

There are two entries for /sys/class/uwb_rc/uwbN/<EUI-48>/BPST.
The second one has a missing description.

Get rid of it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-uwb_rc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-uwb_rc b/Documentation/ABI/testing/sysfs-class-uwb_rc
index 85f4875d16ac..a0578751c1e3 100644
--- a/Documentation/ABI/testing/sysfs-class-uwb_rc
+++ b/Documentation/ABI/testing/sysfs-class-uwb_rc
@@ -125,12 +125,6 @@ Description:
                 The EUI-48 of this device in colon separated hex
                 octets.
 
-What:           /sys/class/uwb_rc/uwbN/<EUI-48>/BPST
-Date:           July 2008
-KernelVersion:  2.6.27
-Contact:        linux-usb@vger.kernel.org
-Description:
-
 What:           /sys/class/uwb_rc/uwbN/<EUI-48>/IEs
 Date:           July 2008
 KernelVersion:  2.6.27
-- 
2.21.0

