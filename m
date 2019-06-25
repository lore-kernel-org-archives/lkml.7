Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A87C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC511208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561492336;
	bh=cvokQUiYje0g+5BxyM/ENlhJA6cq6C9FFJ1lZj9NgpY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S+9tNtD0nHEBvfLu3QqUdykIRDj0GXirKg2QIYc/g+fBJEiuonkmO8lOc5bZcv99w
	 CFW2vPANUzpbvO+upcUxaHQ3c+bvcUr2wDC6fDsxCwIwYmszv0AhrVav0LJc8IjWHz
	 PBBlNBrDgQVkugb/LYJZiY+6NHuA0ORNiksXAx4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfFYTwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYTwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:52:13 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.24.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3089F2063F;
        Tue, 25 Jun 2019 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561492332;
        bh=cvokQUiYje0g+5BxyM/ENlhJA6cq6C9FFJ1lZj9NgpY=;
        h=From:To:Cc:Subject:Date:From;
        b=pDkvQ3BmON+Hw7bFUBMMkyDyxwHg7Zrnwspjr80kRGcOVzZMiEgTBeXxPfH8hXZnk
         07D1xgxS63FSrLnoa26TOADF2KldoBCbESsdSQT22HjoSYd2kCUMGffkYhDSwasn8i
         pRTLNHahcrUU+hXn0E3hOCPHpiGMY0ZhyYPDz690=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6 0/2] fTPM: firmware TPM running in TEE
Date:   Tue, 25 Jun 2019 15:52:07 -0400
Message-Id: <20190625195209.13663-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:

 - Address comments from Ilias Apalodimas

Sasha Levin (2):
  fTPM: firmware TPM running in TEE
  fTPM: add documentation for ftpm driver

 Documentation/security/tpm/index.rst        |   1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst |  31 ++
 drivers/char/tpm/Kconfig                    |   5 +
 drivers/char/tpm/Makefile                   |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c             | 356 ++++++++++++++++++++
 drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
 6 files changed, 434 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h

-- 
2.20.1

