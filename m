Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15BC32756
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B87C21EF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbfHGNVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:21:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52751 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388059AbfHGNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:21:46 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost.localdomain)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1hvLsm-0002TB-34; Wed, 07 Aug 2019 15:21:36 +0200
Message-ID: <5707aee16681065a975ed42a06069674c3127edb.camel@pengutronix.de>
Subject: Re: [Tee-dev] [PATCH v8 0/2] fTPM: firmware TPM running in TEE
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        thiruan@microsoft.com, tee-dev@lists.linaro.org, jgg@ziepe.ca,
        ilias.apalodimas@linaro.org, rdunlap@infradead.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        bryankel@microsoft.com
Date:   Wed, 07 Aug 2019 15:21:33 +0200
In-Reply-To: <20190711200858.xydm3wujikufxjcw@linux.intel.com>
References: <20190705204746.27543-1-sashal@kernel.org>
         <20190711200858.xydm3wujikufxjcw@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I spent some time with the fTPM module and TA on a Nitrogen6X with the
latest OP-TEE master. After stumbling through the "tee_supplicant no
persistent storage" problem, my module now issues the following error
message on module load:

[   34.633252] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff0006
[   34.641035] tpm tpm0: tpm_try_transmit: send(): error -65530
[   34.647008] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff0006
[   34.654788] tpm tpm0: tpm_try_transmit: send(): error -65530
[   34.660480] ftpm-tee ftpm: ftpm_tee_probe: tpm_chip_register failed with rc=-65530
[   34.678087] ftpm-tee: probe of ftpm failed with error -65530

To me the TEE_ERROR_BAD_PARAMETERS indicates some ABI issue between the
TA and the kernel module. Note that I built the TA from 
https://github.com/microsoft/MSRSec.git with commit
6bb57db632c424f87cbaf7ec6f9c89be7682b3c0. Maybe this is not the correct
version, I had some problems building the module from the repository
mentioned in the Patches

Regards,
Rouven Czerwinski
-- 
Pengutronix e.K.                           |            		 |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

