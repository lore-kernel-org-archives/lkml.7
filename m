Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50365C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218802077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDLQ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:27:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35667 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLQ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:27:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so12724997wrp.2;
        Fri, 12 Apr 2019 09:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5+4E/rJW6bkMSnXyhgzur7P2hxxsJwecT3u7ObHTnI=;
        b=DdbBVhOHKAQO3o8EnqRrV+Levf0VEx/o7OsG2K56zD+sh8/k6RkhiZVz/+WEqsNnfb
         J4vAUlxX+VVkESdSIvMkTCMXTxvjPg1NOSwyk+2x3OiZTTwOoLoucqea+ghe95Le1Snl
         Kgy2eDDNcC8DMz8ZFZ2ibd28aQxTINagg3Iddros2YmeVmAerucK7THrBxEOtb0FJZjE
         6Ao3vEtkkezIGJ3NAVl6xaclEtWD9TFK4wnyTMXCQr6q9dus2GkifcRKOl0gwzNLD2k2
         wOiZLNFdP9LoV1n1l3MTw34oWrMT0dN5Gudn8mNhpY6pRINksdAdWDK1aMecrmrLbMF/
         mQuw==
X-Gm-Message-State: APjAAAVTbrnnA5TPH0h67e7c3uibXTV7h9/MqjKwnh88ZOFOu80YGMbx
        I7V1OKnxy+j/hcwrXVbFRMY=
X-Google-Smtp-Source: APXvYqy4y4KaEXss8n5JISBWQeC0I1P2yraTUQTPVpZBWphzA0IugDemX/QiqFzTggvFYd+i3mwmLg==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr7258204wru.161.1555086423600;
        Fri, 12 Apr 2019 09:27:03 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id m17sm33963596wrx.3.2019.04.12.09.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:27:02 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] ARM: dts: am335x: Replace numeric pinmux address w. macro for remaining boards
Date:   Fri, 12 Apr 2019 18:26:10 +0200
Message-Id: <20190412162627.24518-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last patch set of the patch series for the remaining 17 boards.

Depends on the following patch set:
[PATCH v2 0/6] ARM: dts: am335x: Replace numeric pinmux address with macro defines

Christina Quast (17):
  ARM: dts: am335x: igep0033: Replaced register offsets with defines
  ARM: dts: am335x: lxm: Replaced register offsets with defines
  ARM: dts: am335x: moxa-uc-2100-common: Replaced register offsets with
    defines
  ARM: dts: am335x: moxa-uc-2101: Replaced register offsets with defines
  ARM: dts: am335x: moxa-uc-8100-me-t: Replaced register offsets with
    defines
  ARM: dts: am335x: nano: Replaced register offsets with defines
  ARM: dts: am335x: osd3358-sm-red: Replaced register offsets with
    defines
  ARM: dts: am335x: osd335x-common: Replaced register offsets with
    defines
  ARM: dts: am335x: pcm-953: Replaced register offsets with defines
  ARM: dts: am335x: pdu001: Replaced register offsets with defines
  ARM: dts: am335x: pepper: Replaced register offsets with defines
  ARM: dts: am335x: phycore-som: Replaced register offsets with defines
  ARM: dts: am335x: sancloud-bbe: Replaced register offsets with defines
  ARM: dts: am335x: sbc-t335: Replaced register offsets with defines
  ARM: dts: am335x: shc: Replaced register offsets with defines
  ARM: dts: am335x: sl50: Replaced register offsets with defines
  ARM: dts: am335x: wega: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-igep0033.dtsi        |  40 ++--
 arch/arm/boot/dts/am335x-lxm.dts              | 120 +++++-----
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  |  42 ++--
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  24 +-
 .../arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 116 ++++-----
 arch/arm/boot/dts/am335x-nano.dts             | 132 +++++-----
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts   | 168 ++++++-------
 arch/arm/boot/dts/am335x-osd335x-common.dtsi  |   4 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi         |  74 +++---
 arch/arm/boot/dts/am335x-pdu001.dts           | 170 ++++++-------
 arch/arm/boot/dts/am335x-pepper.dts           | 200 ++++++++--------
 arch/arm/boot/dts/am335x-phycore-som.dtsi     |  60 ++---
 arch/arm/boot/dts/am335x-sancloud-bbe.dts     |  62 ++---
 arch/arm/boot/dts/am335x-sbc-t335.dts         | 152 +++++-------
 arch/arm/boot/dts/am335x-shc.dts              | 226 +++++++++---------
 arch/arm/boot/dts/am335x-sl50.dts             | 208 ++++++++--------
 arch/arm/boot/dts/am335x-wega.dtsi            |  68 +++---
 17 files changed, 912 insertions(+), 954 deletions(-)

-- 
2.20.1

