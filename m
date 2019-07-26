Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BFAC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8786C218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="rh4n4TLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGZPZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:25:43 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:45074 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbfGZPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:25:39 -0400
Received: from wiesinger.com (wiesinger.com [84.113.44.87])
        by vps01.wiesinger.com (Postfix) with ESMTPS id 88D6A9F1FD;
        Fri, 26 Jul 2019 17:25:36 +0200 (CEST)
Received: from [192.168.0.14] ([192.168.0.14])
        (authenticated bits=0)
        by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id x6QFPYAM011882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Jul 2019 17:25:35 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com x6QFPYAM011882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1564154735;
        bh=y4jI+N3udLkUBt/fdlluM+w0Q7vkRjreRmtO4xFTGMc=;
        h=Subject:References:To:From:Cc:Date:In-Reply-To:From;
        b=rh4n4TLWnQdWhmU5yzvkShXSQWJY7ncWE7fsOBg28ZJcMils48RwZxjhUXpyX0k5B
         i7EnWgys+08L+eb5a6xOxHtolE7be5K1zMsxX75foKVQhYNU61M58uUae0K1dnr0ey
         jdSnZHR+MomzLLOpMwwHxhpuZ6nznn75V6o4RRJhd6fD/+lbsvfjqzCtwRxkE+7PQs
         zGWUYJclWfmLHdOyZMJOzM1Olefe7GtEN5p2VUxtftjBdtMOEnvBUvpAn0bFmXK+Dc
         7cN6e37ccsknS+fYi+caZwVhab4Iv5oILeWfukquRmj3J/VS1aDv4y1upx1TH3Cupi
         /jfkrseu5mHMdDkhqYvdEFCgSLVqXa0+ud9tynlOsRFf/HQvqJY62kzKCpf3kCAJgC
         ceX7M2Qalhvv1tw+Gwd5JkMpvfhIc9jdadCcCJmFSlCTuOdbmsc3fytAUF0W5VWX7I
         geHj/Rw0YnU2yerNyXhAwLvEYGyzlD/sn0p+ah5JvGLa1G5RrxCi3POrYraOvsx/62
         AuzQ+Lp1tthpBCy75fhcrBGmvpliElzSGEkExHS4MZci8v8zidL1J6mp0vdp79DVOY
         4kd6tCPL+mwW4uzevhwNhImH3kiJba6CuAy3IFcPKyPGezoJoT+75sJ1ZVF//2wN1I
         aXosbySzGCo+Hk3Iv2pMTci0=
Subject: platform/x86/pcengines-apuv2: Missing apu4
References: <02b34d18-27bc-cb48-f698-03df61df7d91@wiesinger.com>
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
From:   Gerhard Wiesinger <lists@wiesinger.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
X-Forwarded-Message-Id: <02b34d18-27bc-cb48-f698-03df61df7d91@wiesinger.com>
Message-ID: <2f22106f-4d13-f3a7-0862-3a71762d62ab@wiesinger.com>
Date:   Fri, 26 Jul 2019 17:25:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <02b34d18-27bc-cb48-f698-03df61df7d91@wiesinger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I saw that the apu4 board is completly missing (also on 5.3rc1). Can you 
please add it. Should be very easy, see below.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/platform/x86/pcengines-apuv2.c?h=v5.1.20

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/pcengines-apuv2.c?h=v5.3-rc1


For further rference:

https://www.pcengines.ch/apu2.htm

https://www.pcengines.ch/apu4c2.htm

https://www.pcengines.ch/apu4c4.htm

Please backport it also to 5.1.x and 5.2.x.


Thnx.

Ciao,

Gerhard


     /* APU4 w/ legacy bios < 4.0.8 */
     {
         .ident        = "apu4",
         .matches    = {
             DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
             DMI_MATCH(DMI_BOARD_NAME, "APU4")
         },
         .driver_data = (void *)&board_apu2,
     },
     /* APU4 w/ legacy bios >= 4.0.8 */
     {
         .ident       = "apu4",
         .matches     = {
             DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
             DMI_MATCH(DMI_BOARD_NAME, "apu4)
         },
         .driver_data = (void *)&board_apu2,
     },
     /* APU4 w/ mainline bios */
     {
         .ident       = "apu4",
         .matches     = {
             DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
             DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu4")
         },
         .driver_data = (void *)&board_apu2,
     },


|

MODULE_DESCRIPTION("PC Engines APUv2/APUv3/APUv4 board GPIO/LED/keys 
driver"); |

