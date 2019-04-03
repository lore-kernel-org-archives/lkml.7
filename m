Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6742DC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDDF20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDCSTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:19:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:53714 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfDCSTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:19:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 11:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="131198429"
Received: from oakcakay-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.144])
  by orsmga008.jf.intel.com with ESMTP; 03 Apr 2019 11:19:37 -0700
Date:   Wed, 3 Apr 2019 21:19:36 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Sudhakar Evuri <suredd@microsoft.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ftpm: firmware TPM running in TEE
Message-ID: <20190403181936.GC17006@linux.intel.com>
References: <20190402193316.15144-1-sashal@kernel.org>
 <20190402193316.15144-2-sashal@kernel.org>
 <20190402135643.02443863@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402135643.02443863@shemminger-XPS-13-9360>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 01:56:43PM -0700, Stephen Hemminger wrote:
> On Tue, 2 Apr 2019 12:33:16 -0700
> "Sasha Levin" <sashal@kernel.org> wrote:
> 
> > +/*
> > + * ftpm_tee_tpm_op_recv retrieve fTPM response.
> > + * @param: chip, the tpm_chip description as specified in
> > driver/char/tpm/tpm.h.
> > + * @param: buf,	the buffer to store data.
> > + * @param: count, the number of bytes to read.
> > + * @return: In case of success the number of bytes received.
> > + *	    In other case, a < 0 value describing the issue.
> > + */
> 
> You are using a docbook style comment but it doesn't start with
> docbook prefix.
> 
> /**
>  * ftpm_tee_tpm_op_recv retrieve fTPM response.
>  *
>  * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h.
>  * @param: buf,	the buffer to store data.
>  * @param: count, the number of bytes to read.
>  * @return: In case of success the number of bytes received.
>  *	    In other case, a < 0 value describing the issue.
>  */

This is different commenting style that we use on anything else
under drivers/char/tpm.

/Jarkko
