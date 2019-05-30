Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7564AC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421DE24422
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559230083;
	bh=CCpOoHuXTWyDNPaIYnLZU0zy5K1knoOQaj9xMEcwB3k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UAHpjGsrW+hP7hBAtCLrGrQKiYVdx+YCjFqoKca7jC6CpE59ZI/vAbpYi+HfMjHws
	 2l2v0/6Z7lwoCYGKFwc6CX5QXz/x2Vvt56Z/M9t9Z6gLoDiZWbPRK6SviWLAkh7HOu
	 JXVbljp95iy0xxobE6+TdfqC4rNBdysLyCjmk4yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfE3P2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfE3P2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:28:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CAB24395;
        Thu, 30 May 2019 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559230081;
        bh=CCpOoHuXTWyDNPaIYnLZU0zy5K1knoOQaj9xMEcwB3k=;
        h=From:To:Cc:Subject:Date:From;
        b=I/vO2kdq0cqoCpmMY0fMGZf7gcpxuXt6IIzwvsrQg/9c1saYjjD3axBWlDxjnho9N
         zuSIZDJW7Ug//kGU25EYNbflQ65/PsjWtYPNkYr+VAd3WRVB0TNu0ZHvgMOy9/sJ44
         lefbwdO25c/LncMsZn/jxZB6PQq5QPC2ZpBB46h8=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 0/2] fTPM: firmware TPM running in TEE
Date:   Thu, 30 May 2019 11:27:56 -0400
Message-Id: <20190530152758.16628-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:

 - Address comments by Jarkko Sakkinen
 - Address comments by Igor Opaniuk

Sasha Levin (2):
  fTPM: firmware TPM running in TEE
  fTPM: add documentation for ftpm driver

 Documentation/security/tpm/index.rst        |   1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst |  31 ++
 drivers/char/tpm/Kconfig                    |   5 +
 drivers/char/tpm/Makefile                   |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c             | 380 ++++++++++++++++++++
 drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
 6 files changed, 458 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h

-- 
2.20.1

