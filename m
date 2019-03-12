Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1C214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCLKMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:12:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43249 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:12:07 -0400
Received: from [5.158.153.52] (helo=ares.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <volker.haspel@linutronix.de>)
        id 1h3eOC-0006TU-Er; Tue, 12 Mar 2019 11:12:04 +0100
From:   Volker Haspel <volker.haspel@linutronix.de>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, han.xu@nxp.com,
        volker.haspel@linutronix.de, john.ogness@linutronix.de
Subject: [PATCH v2 0/1] spi: spi-fsl-qspi: call spi_unregister_controller 
Date:   Tue, 12 Mar 2019 11:12:02 +0100
Message-Id: <20190312101203.14207-1-volker.haspel@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 * use devm_spi_register_controller() instead of calling
   spi_unregister_controller() in the remove function

Thanks
Volker

Volker Haspel (1):
  spi: spi-fsl-qspi: use devm_spi_register_controller

 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.0

