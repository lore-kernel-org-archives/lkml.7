Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C80C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0560220709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKOBRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:17:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:45928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727020AbfKOBRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:17:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF891AEAB;
        Fri, 15 Nov 2019 01:17:52 +0000 (UTC)
Subject: Re: [PATCH 7/7] arm64: dts: realtek: Add RTD1395 and BPi-M4
To:     James Tai <james.tai@realtek.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-8-afaerber@suse.de>
 <c0dfa7d415ed4883ade0a903547270b3@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <09a0983f-cd5a-d855-4ab3-cd95490ec391@suse.de>
Date:   Fri, 15 Nov 2019 02:17:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c0dfa7d415ed4883ade0a903547270b3@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 13.11.19 um 03:57 schrieb James Tai:
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x98000000 0x0 0x98000000 0x68000000>;
>> +
>> +		rbus: r-bus@98000000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x98000000 0x100000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0x0 0x98000000 0x100000>;
> 
> The r-bus size of RTD1395 is 0x200000‬.

Fixed.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
