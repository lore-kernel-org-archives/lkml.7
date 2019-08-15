Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16555C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10252084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LhV+cqdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfHOSep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:34:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:42983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732974AbfHOSen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565894067;
        bh=4U1p4f+jfE8K6OohTuUOCs76mL7r63DrveLltSU5d4c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LhV+cqdI+lprBIj2hMjL3gJeo/c20eBtxgdvpx7HWuVvMORPrtqzRd69SZj22/n9y
         wNboKlMZ7cSNnmVliIQvudmxJq1EFameGlIDh+8QZ8fSh1yAeAHGDIDTkcgVHdIek2
         aTva+1DqdPRp8I9E6rgLT9GLx/A0O5DSoYYI1Hnw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MpUUm-1icsRy3Ysu-00pqyO; Thu, 15 Aug 2019 20:34:26 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 3/3] bcm2835-defconfig-64-next-2019-08-15
Date:   Thu, 15 Aug 2019 20:34:03 +0200
Message-Id: <1565894043-5249-3-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565894043-5249-1-git-send-email-wahrenst@gmx.net>
References: <1565894043-5249-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:ieIssjeS3M87b//1wptjCQdyqXxFZSiRtONWxZ1aeDN1BTiJ4q3
 meJnJqS5X+tkxD2xbJiBPU4AFXKXdBty2/u+bjd8jbVGag+2vAmP/RTu068D67fUh96c+Cy
 j1frzcQUUijLWrWCwxW0tXSodOkbijnH1w7tLm36lEKjOHR8RqnEzEhKMlnH0yr0Z0S/kj0
 6JV89oB/AoFCCDBu07nlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t3wIIpspCao=:ENao8h3FtHLSNX8ElhDfKB
 lgAUFnx0IIMAEPhk6BHCyOcJg3hpfslzqrYl0BCGt17shA4IRSS0qDORZtDC4+7vHirvv4xIh
 AfyGmTILtZh9k0rUJMQkNXAtGlL8v+FemOwsCriNwTdIf6rNjlcc9xK48UneiCEKoM6qR/KvV
 z9RoezXPDJHL1Jvx7JVBEvLsjv9b7phhmhNAsYZQW8O4++3Zf9Mp9YbK8xTgIJ5Cg9bvDOC5H
 jVmgLOhZ2TaNODCvqpK1ZiJec1shCX7EFVFAx/EVTgHUW3jcgw1ytT6ciFOtHxsGHlzkQzx12
 vt9SjO5UX6WoEDTctxfRO8IX/MtY+aWNf0JOT+OsMFK20q46b4gqizWZblmvEiWZ6RyYh2Fyq
 DtK3D9Hw1rlLhNQYBtsLOAEXTecFw6v1KIIslVKZwkPo+/oWMYJdpABHqkJulw32rz+EhrXSX
 QMPeDlfH4GrXa2hwkF+cZMG5mtJ6zGQSHrgn7PQnKbMI8YF++vwNWJWyejoptlugeuNVHy2CM
 Z2Z2q2aWxwJzcYAL12HtJY1K8c1TX/JXCkewP5PmacZCSsEFoCyPjZQADlu/CwIdlWzGkLHjM
 f7DX1LmsNkGeZzRA8+DzREVyUmbE001rg7E2b1ToAXeX2m/V3CDHI1Z++ukL0Ly9zHfb8rhp+
 CJLoxJNWgFWlTT+gsAcRCMCnBN8LgYA60pJ9kN3VY4Ul6m2hk2/tvqBQdI93JyBa9gzvnh3pX
 ho1PntL93BzwQVt+oDQOHTwpZcRpLtUdTpkNQn3GXel8bxSSSPNdhlpLRjJjiQPg5qMqX6A73
 AAgoqKkL3yYP8CfgaFYrPTMDqJAGuZO05pGhlkiDn56Xw6OsF9LYBG2YgII6w1jdrRiUMBG51
 p1VJ6byJaffhvjZj2nDMEdjURrNQi/xkexQaNjXpMcwsDUZqv2KKH1KK97XwYEYSjjph8x46e
 I9vbdfBD8N1CgyHK2M0k7vL1r7h5WoLRYAtU/74Pe6/h49NnHJobxWo16pUaiYUPtiAFGvhMt
 wkI87HLAphINvGq0YCNSyfCNFb9TJbCEVM5YxoEqIjRHWxOz30xkHzLPOAzgvJxH9LaqcYtaX
 yPVzMbJsys4uiZCg+UHqnqMPgpuv3LrjZ2ObE54nUcgSVRAcomcctmKc8U9ryIT/ehRcDZqaD
 q5hTGdgxiH9pvGvyKOjYtFa6VbKeHiZOWmDW6QFeBSxn7/sA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-64-next-2019-08-15

for you to fetch changes up to e2dd73ac4440f7143e990e76bad9a46dc63a5951:

  arm64: defconfig: enable cpufreq support for RPi3 (2019-07-23 23:17:09 +0200)

----------------------------------------------------------------
This pull request enables the new RPi cpufreq driver in the 64-bit
defconfig.

----------------------------------------------------------------
Nicolas Saenz Julienne (1):
      arm64: defconfig: enable cpufreq support for RPi3

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
