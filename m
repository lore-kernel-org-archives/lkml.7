Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F585C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441432075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="l0gpDVDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFUR3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:29:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfFUR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:29:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5LHSX3J1666602
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 10:28:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5LHSX3J1666602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561138114;
        bh=WRGRSwMjS+gsCyKb+EZz9hlahlXg6vwSnnie4pPAk3c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=l0gpDVDjxbKhhqO48wRcB5NiS2QsSf2Hr8KagsGLZOrnxPub2/FJqYlYC4lR85GKP
         mPErQwdNtmc8TjXIHQha3mjhCFa4lJjkjItkGkKDDO8krOWzHoumDNey12Ug+tlETq
         g2ZRSPxwHxzB7X2pZSiQQAb/XZoiPilFiWoAu7Wx1mSz4MAz8rDkooI/dIDO7rXVax
         FSmKTW5m7hqPZv23GdoB6HSUnb1BEmr74tmSI3hnTOddkPiLC9FGes6hIea3smmJml
         8nvkkZcctK9E5j/JLHgCdsFtfiGOJWVqZM6hJjZmq6dWNCpuJ3Oj0pkv5BEvde0NlY
         ffD7i90KKehtw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5LHSWEZ1666599;
        Fri, 21 Jun 2019 10:28:32 -0700
Date:   Fri, 21 Jun 2019 10:28:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Krzysztof Kozlowski <tipbot@zytor.com>
Message-ID: <tip-166da5c5462f4cf299e0daa47c7384617c1699d7@git.kernel.org>
Cc:     x86@kernel.org, ard.biesheuvel@linaro.org,
        yamada.masahiro@socionext.com, tglx@linutronix.de, bp@suse.de,
        linux-kernel@vger.kernel.org, kilobyte@angband.pl,
        mingo@kernel.org, geert+renesas@glider.be, darwish.07@gmail.com,
        akpm@linux-foundation.org, krzk@kernel.org, mingo@redhat.com,
        hpa@zytor.com, alexey.brodkin@synopsys.com
Reply-To: x86@kernel.org, ard.biesheuvel@linaro.org,
          yamada.masahiro@socionext.com, bp@suse.de, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, kilobyte@angband.pl,
          mingo@kernel.org, darwish.07@gmail.com, geert+renesas@glider.be,
          akpm@linux-foundation.org, krzk@kernel.org, mingo@redhat.com,
          hpa@zytor.com, alexey.brodkin@synopsys.com
In-Reply-To: <1559635284-21696-1-git-send-email-krzk@kernel.org>
References: <1559635284-21696-1-git-send-email-krzk@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/defconfigs: Remove useless
 UEVENT_HELPER_PATH
Git-Commit-ID: 166da5c5462f4cf299e0daa47c7384617c1699d7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  166da5c5462f4cf299e0daa47c7384617c1699d7
Gitweb:     https://git.kernel.org/tip/166da5c5462f4cf299e0daa47c7384617c1699d7
Author:     Krzysztof Kozlowski <krzk@kernel.org>
AuthorDate: Tue, 4 Jun 2019 10:01:24 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 21 Jun 2019 19:22:08 +0200

x86/defconfigs: Remove useless UEVENT_HELPER_PATH

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit

  1be01d4a5714 ("driver: base: Disable CONFIG_UEVENT_HELPER by default")

as its dependency (UEVENT_HELPER) was made default to 'n',

2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,

3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Adam Borowski <kilobyte@angband.pl>
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1559635284-21696-1-git-send-email-krzk@kernel.org
---
 arch/x86/configs/i386_defconfig   | 1 -
 arch/x86/configs/x86_64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 2b2481acc661..59ce9ed58430 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -130,7 +130,6 @@ CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index e8829abf063a..d0a5ffeae8df 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -129,7 +129,6 @@ CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
