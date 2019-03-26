Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4CC2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfCZGq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:46:57 -0400
Received: from mx.socionext.com ([202.248.49.38]:11549 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730569AbfCZGch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:37 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Mar 2019 15:32:35 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 2AE0C6117D;
        Tue, 26 Mar 2019 15:32:35 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 26 Mar 2019 15:32:35 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id DA31840385;
        Tue, 26 Mar 2019 15:32:34 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id BAA92120487;
        Tue, 26 Mar 2019 15:32:34 +0900 (JST)
From:   Shinji Kanematsu <kanematsu.shinji@socionext.com>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, orito.takao@socionext.com,
        sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com,
        kanematsu.shinji@socionext.com
Subject: [PATCH 0/2] Add Updown Counter support for Milbeaut M10V SoC
Date:   Tue, 26 Mar 2019 15:32:34 +0900
Message-Id: <1553581954-13487-1-git-send-email-kanematsu.shinji@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patch which adds Updown Counter support on
Milbeaut M10V SoC.

The Updown Counter counts input pulse signal from external quadrature encoder.
It also has input pulse signal counter function.

Shinji Kanematsu (2):
  dt-bindings: iio: counter: Add Milbeaut Updown Counter
  iio: counter: Add support for Milbeaut Updown Counter

 .../bindings/iio/counter/milbeaut-updown_cnt.txt   |  22 ++
 drivers/iio/counter/Kconfig                        |  12 +
 drivers/iio/counter/Makefile                       |   1 +
 drivers/iio/counter/milbeaut-updown.h              |  38 ++
 drivers/iio/counter/milbeaut-updown_cnt.c          | 385 +++++++++++++++++++++
 5 files changed, 458 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
 create mode 100644 drivers/iio/counter/milbeaut-updown.h
 create mode 100644 drivers/iio/counter/milbeaut-updown_cnt.c

-- 
1.9.1

