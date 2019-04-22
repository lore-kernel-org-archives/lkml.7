Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739E4C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350DC20693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NrDfKdSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfDVLs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:48:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46368 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfDVLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:48:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3MBmito129753;
        Mon, 22 Apr 2019 06:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555933724;
        bh=zJQuFwl7cwef0Z73DtTc+6fGNDhHL5MERp1j1v0e6m0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NrDfKdSgk+Y4m3/dn7PWSmkVwSBkBeTDqEfvTkyN4UR3zDUDZXwLkXP20YFLrMelk
         z8VJUayKocrE2gB6KqywyOM+Oskhus8dD9TIshYLjMEs4C5gBp9rfzO51ylXAV5cFM
         DOxvSGM6+vQQ8DxrjMYofsrcyfC/cpr7YbgSyxA8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3MBmhCf078999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Apr 2019 06:48:43 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 22
 Apr 2019 06:48:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 22 Apr 2019 06:48:43 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3MBmeXu125536;
        Mon, 22 Apr 2019 06:48:41 -0500
Subject: Re: linux-next: manual merge of the phy-next tree with the qcom tree
To:     Andy Gross <agross@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20190418152954.255015e1@canb.auug.org.au>
 <d194fa50-8bff-544e-eb88-128810f525f9@free.fr>
 <20190419045844.GA3322@hector.attlocal.net>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4e8aefdf-d0bb-9dcd-63b1-94de9d4e69d4@ti.com>
Date:   Mon, 22 Apr 2019 17:17:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419045844.GA3322@hector.attlocal.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/19 10:28 AM, Andy Gross wrote:
> On Thu, Apr 18, 2019 at 09:35:44AM +0200, Marc Gonzalez wrote:
>>
>> It is not clear to me what I could/should have done differently to avoid
>> the conflict?
> 
> I dropped the patch for now.  We can deal with this later as it is trivial.
> The best way probably would have been for Kishon to take this patch as well.
> Then he would have fixed it up and no one else would have seen it.  But we'll
> deal with it in a few weeks.  No biggie.

I've included "dt-bindings: phy-qcom-qmp: Tweak qcom,msm8998-qmp-ufs-phy" in
linux-phy tree now.

Thanks
Kishon
