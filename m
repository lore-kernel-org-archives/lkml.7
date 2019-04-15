Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C12C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AA120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555343814;
	bh=7dOXUAHOrd3stZI8oiR/bmI+G1sgcngs4onAY15LRN4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eoVKyy2DIk30Bv1BIFnQCUDBFhpcaBFv6w4rC+Nz3JIySlYLoOyIXE9/7XcGmnHMT
	 ghqKnN+8VgsZSLJW62qJySFJt4mlrbqKEQESQrYH22yocgQyEnciY1cRuv7E3mkcZG
	 xOtSOVGuthWaj5hHcHrUBgwsDTKECpddkj0eaOcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfDOP4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfDOP4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:56:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEFB20825;
        Mon, 15 Apr 2019 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555343812;
        bh=7dOXUAHOrd3stZI8oiR/bmI+G1sgcngs4onAY15LRN4=;
        h=From:To:Cc:Subject:Date:From;
        b=dZQzykW+EP6CePtAcXFlY00NsSzcHwvX/lZbyZ2b9TNDXoHeIEt7L0iFu1Bqp1CnM
         x7MdapdWbJOFyvCeEg67PbBlTme6TT/veuXotTHhMbj8G4F/Ud0jMy+5kuxypMqiHN
         Qq/H3Frlj2lYnFyjsCbZd6n0YDlnSl2fBloFykmo=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Date:   Mon, 15 Apr 2019 11:56:34 -0400
Message-Id: <20190415155636.32748-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Sasha Levin (Microsoft)" <sashal@kernel.org>

Changes since v2:

 - Drop the devicetree bindings patch (we don't add any new ones).
 - More code cleanups based on Jason Gunthorpe's review.

Sasha Levin (2):
  ftpm: firmware TPM running in TEE
  ftpm: add documentation for ftpm driver

 Documentation/security/tpm/index.rst        |   1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst |  31 ++
 drivers/char/tpm/Kconfig                    |   5 +
 drivers/char/tpm/Makefile                   |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c             | 366 ++++++++++++++++++++
 drivers/char/tpm/tpm_ftpm_tee.h             |  47 +++
 6 files changed, 451 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h

-- 
2.19.1

