Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CFFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FEA20733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLQLQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:16:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:42449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfLQLQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:16:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="389789917"
Received: from pbroex-mobl1.ger.corp.intel.com ([10.251.85.107])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2019 03:16:12 -0800
Message-ID: <1a68db2aee382a1b0472cf0b81a809bc089e622d.camel@linux.intel.com>
Subject: Re: [PATCH] drivers: char: tpm: remove unneeded MODULE_VERSION()
 usage
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 17 Dec 2019 13:16:11 +0200
In-Reply-To: <20191216084230.31412-1-info@metux.net>
References: <20191216084230.31412-1-info@metux.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-16 at 09:42 +0100, Enrico Weigelt, metux IT consult wrote:
> Remove MODULE_VERSION(), as it isn't needed at all: the only version
> making sense is the kernel version.

Take the following line away:

> See also: https://lkml.org/lkml/2017/11/22/480

And just before SOB:

Link: https://lkml.org/lkml/2017/11/22/480
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

You have some extra cruft there. It should be:

Signed-off-by: Enrico Weigelt <info@metux.net>

/Jarkko

