Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54634C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312C8206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfICTPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:15:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58040 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfICTPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:15:05 -0400
Received: from [10.91.6.157] (unknown [167.220.2.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id B6D6020B7186;
        Tue,  3 Sep 2019 12:15:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6D6020B7186
Subject: Re: [PATCH v4] tpm: Parse event log from TPM2 ACPI table
To:     jarkko.sakkinen@linux.intel.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190831051027.11544-1-jorhand@linux.microsoft.com>
 <20190903182742.rmqthgu6rms3uill@cantor>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <e86fd977-9c16-68df-e38e-4f9650ec5ac9@linux.microsoft.com>
Date:   Tue, 3 Sep 2019 12:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903182742.rmqthgu6rms3uill@cantor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 11:27 AM, Jerry Snitselaar wrote:
>> +        len = tpm2_trailer.minimum_log_length;
>> +        start = tpm2_trailer.log_address;
> 
> Are your builds not failing here? Both v3 and v4 have this.
> 

Ya, I saw the kbuild bot failure and fixed in v5. I'm not entirely sure
why I didn't catch it locally. Maybe a was compiling against the wrong
tree or something silly like that.

Thanks,
Jordan
