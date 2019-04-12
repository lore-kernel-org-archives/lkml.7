Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B194C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5096E2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcltYHKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDLQ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:27:47 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:36296 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:27:46 -0400
Received: by mail-oi1-f201.google.com with SMTP id t66so4814327oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7TzQmInxTWUl6X3CTT5BO70JvWZxMxCZRjycIU7Ya/4=;
        b=PcltYHKRIuM8vHlzhVCu4OYcwec0vK5s8EcwuHuilc4fxpaAKUFJjH86ALE7l/DRKg
         YuLbX70y4/Vg4Vg9EK2HSnIrXk6NJPJw8y8+WRyWzGUmaE4xYKd8/eGCmMP+7E65HJRC
         V9LOKMTfLmoNhsyI8Fvvp3Rg/rTOhs63zBKShzPdFg+1ZUCEqbmDwMpn+4h4yoVpIYf6
         nlwJi277LS72hu0Q1cITiPFkNW6BG5CFqhch4x11dbZ6ThYr5KGyoXAktTqjmQBaHsCG
         22F/tjMXbSZ8ao7S3Wy90oxcfsbkNE4Ucyp55kttDSZvS+v+X9tVD0xDN9UCOYld79z2
         ahDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7TzQmInxTWUl6X3CTT5BO70JvWZxMxCZRjycIU7Ya/4=;
        b=r+oapHsrom+YpsmHBBtQUapJEQ94rObyCtk4U1c0VPf0dyeaJmSXp4RMB1ildQnHx3
         892fSgrJJr3Poe9MMzreRAZLzGCE8HnzjMUd9/FXhufVP32Iy8ZoUimpRBTnFM0OBrAP
         wpIHhWXnkWhYkNngpoU23LOa5Ksg6BL6I5s9fmWsKVW8RQ+1e0vEXGuir3st48H55gFB
         BjvkpEAYmCp9ET9wKaEwSaXxe8j5C13FcdsgK97vRAxvMM00aE+kkwTj2o9WHgXmtNih
         exC1sPTyruK8w3sYKoeKb8Xv+bmsYEdpinu9ZmqOFgfGFifRLTcVaO2SJWTf9f25czsA
         xGjQ==
X-Gm-Message-State: APjAAAX4DsHO/q3r/ef7JjQlUoQHqvDP/OIfR4fa1w6oa1a0szzJ9x6E
        Oo79f2u3+hgEKc9mmF2NfaYB15WeGVT0
X-Google-Smtp-Source: APXvYqz1DvyAxVFaZuGtRTF6OQPJhjzK7BZHyl7vF8rThUVvoRyTacyB36EY9cie0Ftt7egBPF0NoxV523v7
X-Received: by 2002:aca:3203:: with SMTP id y3mr5136634oiy.58.1555086465835;
 Fri, 12 Apr 2019 09:27:45 -0700 (PDT)
Date:   Fri, 12 Apr 2019 09:27:42 -0700
Message-Id: <20190412162742.65962-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] Documentation: hwmon: ir35221: fix company name
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, linux@roeck-us.net, jdelvare@suse.com,
        corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the company name from "Infinion" to "Infineon."

Signed-off-by: Patrick Venture <venture@google.com>
---
 Documentation/hwmon/ir35221 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/ir35221 b/Documentation/hwmon/ir35221
index f7e112752c04..3e82f3d93f44 100644
--- a/Documentation/hwmon/ir35221
+++ b/Documentation/hwmon/ir35221
@@ -2,7 +2,7 @@ Kernel driver ir35221
 =====================
 
 Supported chips:
-  * Infinion IR35221
+  * Infineon IR35221
     Prefix: 'ir35221'
     Addresses scanned: -
     Datasheet: Datasheet is not publicly available.
-- 
2.21.0.392.gf8f6787159e-goog

