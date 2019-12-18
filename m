Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288A1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EF321582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLROjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:39:43 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:35938 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbfLROjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:39:43 -0500
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 15/A4-10575-C2A3AFD5; Wed, 18 Dec 2019 14:39:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRWlGSWpSXmKPExsVy8IPnUV0dq1+
  xBl/fi1jc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTXj4sG1jAXnWCp+belib2C8
  xdzFyMUhJLCeUeLMup1MXYycQE6FRP+ZP+wgNq+Am0Trpf+sIDabgIXE5BMP2EBsFgFViRuz7
  zOD2MICvhLNa9cD2RwcIgIqEufemIOYzAIREn9OMUNMEZQ4OfMJC4jNLCAhcfDFC2aITQYSpx
  c0gsUlBOwlpr+/CjZFQkBfovFYLETYUOL7rG9QJeYSzw9sYJ7AyD8LydRZSKYuYGRaxWieVJS
  ZnlGSm5iZo2toYKBraGika2hpomtmrpdYpZuol1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokR
  GJgpBYecdzB++PpW7xCjJAeTkiivUsbPWCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvO8sfsUKC
  RalpqdWpGXmAKMEJi3BwaMkwrsbJM1bXJCYW5yZDpE6xajLsfPovEXMQix5+XmpUuK8VpZARQ
  IgRRmleXAjYBF7iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw7yqQVTyZeSVwm14BHcEEdAS
  HJtgRJYkIKakGpl6pNT+L3Y8u+3NFkPf7AYfAmyova1mW/g+XKN8yS+Zpg8eu7ft/HPst0SB8
  33jncl3p5KlLtVoCzOMDluvP9HmWU7BDcbfOrhqGcINPHLulL754x67/6W1f12m/C2/q5Lxjy
  7bf5w2eqXpip/PRiQ0SVv5bb/3pOHb++ETd6c+3XjvU3aH6R2Oj+VW770ELTlUKn65TcxTYqr
  By2+mOBScucAVLpL2eLuXz+9AW7/9libd1kjT6lLZkKbos8Q3f87JsehNv4eLVU8UOznCvD5o
  232/JLrMHfht+t9d9euwTfuWfb6fu5G1T+Gatsl/WWnFr1/2pRcWqx1sOTgw6n/Q8duUq7YkW
  qUZ6DtNrj/spsRRnJBpqMRcVJwIAFe3LJ1MDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-7.tower-268.messagelabs.com!1576679979!958129!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16157 invoked from network); 18 Dec 2019 14:39:40 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-7.tower-268.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 18 Dec 2019 14:39:40 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 18 Dec 2019 14:39:38 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 B6A333FB8D; Wed, 18 Dec 2019 14:39:38 +0000 (GMT)
Message-ID: <cover.1576678683.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Wed, 18 Dec 2019 14:39:38 +0000
Subject: [PATCH 0/2] Resolve revision handling and add support for DA silicon
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 18/12/2019 10:41:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes the currently broken revision handling in the driver's
i2c_probe() function and then adds DA support to existing permitted revisions.

Adam Thomson (2):
  mfd: da9063: Fix revision handling to correctly select reg tables
  mfd: da9063: Add support for latest DA silicon revision

 drivers/mfd/da9063-core.c            |  31 -----
 drivers/mfd/da9063-i2c.c             | 254 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/core.h      |   1 +
 include/linux/mfd/da9063/registers.h |  15 ++-
 4 files changed, 240 insertions(+), 61 deletions(-)

-- 
1.9.1

