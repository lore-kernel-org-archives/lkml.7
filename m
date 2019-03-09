Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FD0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD6420815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155242;
	bh=GqkYmnUcSyG/S4JZegl+omwn6tFf5InF01HdLAgdYsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nU3i5u6VQcddi/w+EPu9WNDPW3+i8ERb+uAw53rb8FIX0tIx8Pq8BulDac+q5R31J
	 uo2pD9AF2U+BM0a/K48HIr/k3vdnZQRVgTKMplNAv5mEfjTsbFznffPfbz//AqAhxF
	 ZWgehgpxFwvoNnACrIeomvb5fypuo3envz0D5mzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCISOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfCISOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:14:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCAA206DF;
        Sat,  9 Mar 2019 18:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552155240;
        bh=GqkYmnUcSyG/S4JZegl+omwn6tFf5InF01HdLAgdYsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uTxY8ZfAUBJCJ/0ECtOvrKADXlY5bqQoKSGRpHLSvwfoGKJyEsWpKOitdnkwayozd
         yfkesnB0GHcbIhL/M/MAyLcW2n8G6/YuqoRWotnQjtc/+X12frG0OuwhbKo7YIv5t/
         a5wjgzt+1Ug4snSfujBJ4fIW3SJCsjdARPGU1VTo=
Date:   Sat, 9 Mar 2019 18:13:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Yang <decatf@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Kionix, Inc.
Message-ID: <20190309181354.4b455353@archlinux>
In-Reply-To: <20190304151912.11485-2-decatf@gmail.com>
References: <20190304151912.11485-1-decatf@gmail.com>
        <20190304151912.11485-2-decatf@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 10:19:10 -0500
Robert Yang <decatf@gmail.com> wrote:

> Kionix manufactured MEMs sensors. There are Kionix acceleromoter sensor
> drivers which can be used with device tree.
> 
> Signed-off-by: Robert Yang <decatf@gmail.com>
I'll apply these now before I forget them but if a DT person
wants to comment I won't be pushing out as non rebasing for
at least a week so plenty of time!

Applied to the togreg branch of iio.git but pushed out for
now as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index bb6f6e8a2eee..e389904ee9bf 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -210,6 +210,7 @@ kiebackpeter    Kieback & Peter GmbH
>  kinetic Kinetic Technologies
>  kingdisplay	King & Display Technology Co., Ltd.
>  kingnovel	Kingnovel Technology Co., Ltd.
> +kionix	Kionix, Inc.
>  koe	Kaohsiung Opto-Electronics Inc.
>  kosagi	Sutajio Ko-Usagi PTE Ltd.
>  kyo	Kyocera Corporation

