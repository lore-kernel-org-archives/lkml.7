Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0423C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC822168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560543697;
	bh=SUff+IuHYY1vqG1JvhChINONwtR73776hlNKIIAyNjU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YwCK5ctUpinNP+PvErYM7lN0wUqYSNqxt7nVmgA29uRW1XZ2U1HuRG8fC9ZVPy98x
	 kErsZp3ovfcIlwYxEu/BtWzu+LociXgsdYFaI8TFJIbO9hHe1qYS/0w8AyMkeRxC3N
	 cc9RRwKE8D4yXfbw6LsXd+Afgo9TC7Ag277XnQ+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFNUVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfFNUVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:21:35 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C402168B;
        Fri, 14 Jun 2019 20:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560543694;
        bh=SUff+IuHYY1vqG1JvhChINONwtR73776hlNKIIAyNjU=;
        h=From:To:Cc:Subject:Date:From;
        b=bj+0zlh6+G7niTDlS56IOmNXnwhNj7nxFjbOH3V5aGw1ydsvaR9GVxSftyGr16TFJ
         F21V0scYHfySAJsB48nFd+7ZUq48qY/uCGsvR63f6wYPGoQQDqmVBAOcanRxv+EBja
         l0xHcf/8xjGjKdzwh98N2XLnKqDMiAWyZ4FwPIwQ=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v5 0/2] fTPM: firmware TPM running in TEE
Date:   Fri, 14 Jun 2019 16:21:25 -0400
Message-Id: <20190614202127.26812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v4:

 - Don't show an error message while waiting for OP-TEE to come up.

Sasha Levin (2):
  fTPM: firmware TPM running in TEE
  fTPM: add documentation for ftpm driver

 Documentation/security/tpm/index.rst        |   1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst |  31 ++
 drivers/char/tpm/Kconfig                    |   5 +
 drivers/char/tpm/Makefile                   |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c             | 382 ++++++++++++++++++++
 drivers/char/tpm/tpm_ftpm_tee.h             |  40 ++
 6 files changed, 460 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h

-- 
2.20.1

