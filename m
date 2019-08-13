Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FECFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C45F2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfHMHJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:09:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40083 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfHMHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:09:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so50768720pgj.7;
        Tue, 13 Aug 2019 00:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QfOWwE3vQqw8AQeTEb1rIQcn0tF6xiUbmO1pG5NRG+s=;
        b=Gan8a50Nmqjlr7WRcPXSe2ZlPvKnwFR6l1+ATvhtzQw/7zYWygSiP2QoVHJzvomZKf
         YUOYVp1+qb3hSi8j9i0rIIOpuatXvw4vLTo683QnbWmxEB05R41W2f0mHBA/JZ26IX8b
         P++Z1DncNryfBvCAVwpVj5wNaE6bRryCeynabJDXSMJ9RJkYMqj8hzy1QQ9RXO1h+lsk
         gmVyVZAOUZvcSnkveC8moDQYjoCKmiputU3THtFFoYH0X/SnaLxhCGGHOOLh5Eit3ly0
         HNlIxXJgEfLcC02GIl+dSizV2bvdZe1DKEl5GdKdMRh35ukio/EQ44aspGEU5Y8ipbTZ
         iX2A==
X-Gm-Message-State: APjAAAWLAMtIBmZD0x+0F1ZoKPSkp7Zc8oLkjYd2+5asVjezo688F1UV
        Meg+faIXeQBq2h/O+hqI2+g=
X-Google-Smtp-Source: APXvYqxqBL7GOftYx/bXsrKx/R0dxSvRGoxLVF1NsqWuqX8vj/CY5YzmVz/Gb0wsiaxEGZFCF1MkuA==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr902510pjw.60.1565680178510;
        Tue, 13 Aug 2019 00:09:38 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id x1sm18787633pfj.182.2019.08.13.00.09.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 00:09:37 -0700 (PDT)
Subject: Re: Bad file pattern in MAINTAINERS section 'SAMSUNG EXYNOS TRUE
 RANDOM NUMBER GENERATOR (TRNG) DRIVER'
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, efremov@linux.com
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212751.27532-1-joe@perches.com>
 <CAJKOXPcyOVLboJHZyEcUx_9HNh+iVq=7OFQN4=qnfL+O4Ld_4g@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <f4e91a72-2d0d-b02e-706e-e53f6f9a2368@linux.com>
Date:   Tue, 13 Aug 2019 10:09:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcyOVLboJHZyEcUx_9HNh+iVq=7OFQN4=qnfL+O4Ld_4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Initially, I've prepared a patch and only after found this discussion. So, please,
look at this patch no more than just a simple reminder that get_maintainers.pl
still emits this warning.

Best regards,
Denis

------------------------ >8 ------------------------
Subject: [PATCH] MAINTAINERS: exynos trng: Remove samsung,exynos5250-trng.txt record

Update MAINTAINERS to reflect that samsung,exynos5250-trng.txt
file never existed.

Cc: Łukasz Stelmach <l.stelmach@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ea3f82e256b..7d213e192626 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14033,7 +14033,6 @@ M:	Łukasz Stelmach <l.stelmach@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/char/hw_random/exynos-trng.c
-F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
 
 SAMSUNG FRAMEBUFFER DRIVER
 M:	Jingoo Han <jingoohan1@gmail.com>
-- 
2.21.0


