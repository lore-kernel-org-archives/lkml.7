Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D27E2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894782;
	bh=EHP+IrkV7CieRmrefAsXb40F+osc2i6h5NMCaefrbTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eYAqEigg5W5HFIpGvl0doMBLTqaRpy5554E/ncFqQC3GdjhzgZc6+7il8CO0ZrGE7
	 uG7BtEH55dEUYAawA7nEB/zzRiw8iHp76IHaUbmLrsnRZdqIcLJNP/7S+rotIYgR2g
	 a5SCJLrFne7Hr4E2SVh8JDjsJkN8jtohA5Ao9Ad4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfDJLMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:12:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfDJLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ifG45tSFXLTwXJb1h6jD264H1aDH2yrbOS4N926T3HM=; b=MEznhMUi68dAY2gC5NZWGvxOOH
        +3X6ZbxOS4cXYlPgjk8OITTzmZUjk/GJy3fhzDNDj1ZN7b8C5FHL59SPtOV0p23fqtzGUanY0jAkv
        uD0NxB2uBEhKvmkWraLb9cAQCa38ZlxB6Jn0zYN3xTTj7afWAQeoIzPGK1BQcION1jN+HiDZaiGZj
        0r4lUw3lbMH9YxeRRrf6ZzmJEud7pS74vPtb0ZlT3eS6kxXxj0c6J11Znt3MdGCtiCsddr9MNkcJj
        2O9ihzHikCyjVEshAJEvK8HCCsJA4FhsFDJQsc81BaTn4OrbkzSGsdoKG1KEdV6WI6erEJ6vjjRsA
        ny7H/OZA==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006mu-JK; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007SZ-A8; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 04/21] docs: hwmon: sch5627: convert to ReST format
Date:   Wed, 10 Apr 2019 08:11:54 -0300
Message-Id: <e3fb7e218af49e4e6132757d6610278f7409df8c.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert sch5627 to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/sch5627 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/hwmon/sch5627 b/Documentation/hwmon/sch5627
index 0551d266c51c..187682e99114 100644
--- a/Documentation/hwmon/sch5627
+++ b/Documentation/hwmon/sch5627
@@ -2,9 +2,13 @@ Kernel driver sch5627
 =====================
 
 Supported chips:
+
   * SMSC SCH5627
+
     Prefix: 'sch5627'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Application Note available upon request
 
 Author: Hans de Goede <hdegoede@redhat.com>
-- 
2.20.1

