Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152DDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCCB20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Leccl4VF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDILi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:38:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53592 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfDILi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:38:59 -0400
Received: from zn.tnic (p200300EC2F0F85004CD156EF53AFFE27.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8500:4cd1:56ef:53af:fe27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09C7A1EC0573;
        Tue,  9 Apr 2019 13:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554809938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RtRrCkVdacUGSYNkkRBH8adV5iH+p+F7ENZlPyIcYLw=;
        b=Leccl4VFOy/mdmDS/VMY0sizMAQe677VZTDAn+kAY4HKPIBilcrirlZCsUpwoKpqSB9oiW
        sT9wx5LLzM0eOmRPRkTyzfQGKUbrBIBs3AtskMJaZvo0GRPaFMQzi8IjmEUTmKYwMkQq2O
        ajBOzEoRClBDnNXGX6PH/RIMzR7Fj6A=
Date:   Tue, 9 Apr 2019 13:38:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190409113849.GB6150@zn.tnic>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-5-Yazen.Ghannam@amd.com>
 <20190408202659.GA5232@agluck-desk>
 <20190408203431.GM15689@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E8F6A61@ORSMSX104.amr.corp.intel.com>
 <20190408205013.GN15689@zn.tnic>
 <SN6PR12MB2639F3E98157872E7C046705F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639F3E98157872E7C046705F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:48:34PM +0000, Ghannam, Yazen wrote:
> Okay, so drop the export and leave the injector code as-is (it's
> already doing a rdmsrl_on_cpu()).

Yes of course. The number of MCA banks is none of modules' business and
should not be exported at all.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
