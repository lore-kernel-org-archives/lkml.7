Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB69C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF3720657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8VlTO0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFYXNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:13:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFYXNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bNOnF9RPhjENVHpzmRNMIxdtfQ6guu6sKYduKcd0Tc8=; b=V8VlTO0pZvD95eJUQjucRK+Rbt
        gO6Y2d2E1MYhOhgMoiK3mYh9wHSdrc7Y4RDWpU/WgZkXW/HbILKz+9VWOpeI9mPPdnknTiW1HEKmV
        4k2j/uzhDJ5RvVDLUMKJ/GWftlXZ9kVhW9SIARyQtBryfonYWlwrQEc+/ZyNatSQoYKsk1LJlFY8c
        zzEQVzP1oauTdWdXBJAefgElIT0JIzbQZ9zS4iUz30xXrqHmwtOKKzcgDbTgf4tSTRmtk2Z/KS58W
        mEdk/ljHdt/Sh9+G4tZ7hzAqyp1+wAIvnG1y9Wvm+N4pNWeEb7VWyNLOoIDy7mEmxqeGMgTEoli91
        0XodM4TQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfud4-0001Kq-Oz; Tue, 25 Jun 2019 23:13:35 +0000
Subject: Re: [PATCH v7 2/2] fTPM: add documentation for ftpm driver
To:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-3-sashal@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fa526626-9eae-98ba-5127-6a4105781a41@infradead.org>
Date:   Tue, 25 Jun 2019 16:13:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625201341.15865-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/19 1:13 PM, Sasha Levin wrote:
> This patch adds basic documentation to describe the new fTPM driver.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/security/tpm/index.rst        |  1 +
>  Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
> 
> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
> index af77a7bbb070..15783668644f 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -4,4 +4,5 @@ Trusted Platform Module documentation
>  
>  .. toctree::
>  
> +   tpm_ftpm_tee
>     tpm_vtpm_proxy
> diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
> new file mode 100644
> index 000000000000..48de0dcec0f6
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
> @@ -0,0 +1,31 @@
> +=============================================
> +Firmware TPM Driver
> +=============================================
> +
> +| Authors:
> +| Thirupathaiah Annapureddy <thiruan@microsoft.com>
> +| Sasha Levin <sashal@kernel.org>
> +
> +This document describes the firmware Trusted Platform Module (fTPM)
> +device driver.
> +
> +Introduction
> +============
> +
> +This driver is a shim for firmware implemented in ARM's TrustZone
> +environment. The driver allows programs to interact with the TPM in the same
> +way they would interact with a hardware TPM.
> +
> +Design
> +======
> +
> +The driver acts as a thin layer that passes commands to and from a TPM
> +implemented in firmware. The driver itself doesn't contain much logic and is
> +used more like a dumb pipe between firmware and kernel/userspace.
> +
> +The firmware itself is based on the following paper:
> +https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/ftpm1.pdf
> +
> +When the driver is loaded it will expose ``/dev/tpmX`` character devices to
> +userspace which will enable userspace to communicate with the firmware TPM
> +through this device.
> 


-- 
~Randy
