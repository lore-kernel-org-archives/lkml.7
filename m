Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67C7C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86D420657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFYXVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:21:44 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:36754 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfFYXVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:21:43 -0400
X-Greylist: delayed 2751 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 19:21:42 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x5PMZ754025278;
        Wed, 26 Jun 2019 01:35:08 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20053)
        id EA30261FCB; Wed, 26 Jun 2019 01:35:07 +0300 (IDT)
From:   Oshri Alkoby <oshrialkoby85@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, oshrialkoby85@gmail.com,
        oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        tomer.maimon@nuvoton.com
Subject: [PATCH v1 0/2] char: tpm: add new driver for tpm i2c ptp
Date:   Wed, 26 Jun 2019 01:35:01 +0300
Message-Id: <20190625223503.367710-1-oshrialkoby85@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for TPM devices that implement the I2C
interface defined by TCG PTP specification.

The driver was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.

Oshri Alkoby (2):
  dt-bindings: tpm: add the TPM I2C PTP device tree binding
    documentation
  char: tpm: add new driver for tpm i2c ptp

 .../bindings/security/tpm/tpm-i2c-ptp.txt     |   17 +
 drivers/char/tpm/Kconfig                      |   22 +
 drivers/char/tpm/Makefile                     |    1 +
 drivers/char/tpm/tpm_i2c_ptp.c                | 1099 +++++++++++++++++
 4 files changed, 1139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
 create mode 100644 drivers/char/tpm/tpm_i2c_ptp.c

-- 
2.18.0

