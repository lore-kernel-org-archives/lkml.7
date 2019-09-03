Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D70C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE492168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567536424;
	bh=s7mcLgKB4jOy/NLAhdS5d6xI925IntO4luJjdKxdMnA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FG9LWdH8mqak5dZFt9rF8/wFDBpOgYw685mr0ukZ3LSqIZZs0N+fYGQmjYDhQTnug
	 cZtUYU4/NdZVNiWkVzZ5cOAHI1SenYvb01xe93TStCkocXyR+pK+asVyBIweimaAXM
	 Ah5Bt/F9umbV4yjk/Xi+TkERaRuGiQbxTWg3MXr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfICSrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:47:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39514 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICSrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:47:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id s12so4324903pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 11:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oInCZCVxRDHHNZQh2zohajIbQXd80RnFiXOh17nr5s=;
        b=pV0K+6WsqKnGeGVMeR8wr7mCyEKmd8L8LCX0iUm9Iyt4rFJ3bq1tX871XScWMsMh2P
         iFpiVouGHEFzVIRE2xFCEeqesbEI4ZUlqApGD5JkoIf4KApARcGdXnOKSdLXoINekkoG
         Ke9iSepR0koQ5GWdHeMIIFxsVqQ2zndzZCHtH6eD+8Zuzir7UMatRyPkAhmXMFyKtp7Z
         m876otbgvrgaRUXlIcJxhuL6FzDv5q3yIYL1343+hzPclWbHon/ZyB+qHNZCDKQTi+qe
         Y10HLZRRb+K7tf9iiOIgsP0b6F4suO8yjMR4eeMPu08AeNPvmB7zjRy8//PA7rQGV9MK
         NulQ==
X-Gm-Message-State: APjAAAW8zC0YEY93qe//nYu9ixb0SqXdzUX7Fw/6LVnZejLTgBUHt6l6
        V6wgv8DubUenB+oUegXHD/xrzQ==
X-Google-Smtp-Source: APXvYqyp6PsxC1jX74zAlOl3wgnSC/9PRLW24Vcbklx8mzvvIBD9O83FyaKqeLaZGizKum9GXqavpg==
X-Received: by 2002:a63:5402:: with SMTP id i2mr31425861pgb.414.1567536422460;
        Tue, 03 Sep 2019 11:47:02 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id j26sm2975585pfe.181.2019.09.03.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 11:47:01 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     netdev@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] net: fixed_phy: Add forward declaration for struct gpio_desc;
Date:   Tue,  3 Sep 2019 11:46:52 -0700
Message-Id: <20190903184652.3148-1-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add forward declaration for struct gpio_desc in order to address
the following:

./include/linux/phy_fixed.h:48:17: error: 'struct gpio_desc' declared inside parameter list [-Werror]
./include/linux/phy_fixed.h:48:17: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]

Fixes commit 71bd106d2567 ("net: fixed-phy: Add
fixed_phy_register_with_gpiod() API")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 include/linux/phy_fixed.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index 1e5d86ebdaeb..52bc8e487ef7 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -11,6 +11,7 @@ struct fixed_phy_status {
 };
 
 struct device_node;
+struct gpio_desc;
 
 #if IS_ENABLED(CONFIG_FIXED_PHY)
 extern int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier);
-- 
2.23.0.187.g17f5b7556c-goog

