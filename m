Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E96C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E10A2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552064688;
	bh=3yOYRbBMPGsq0XJ7ErPVFh/TDFyNM/K59FU5669SGGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U7ANAyN9pjn8+iz1Yi2GTmsd0JZxUknRSxTDOLZSIN5Afb9lRmCsy/PDUHTHlKaFt
	 mgtuRYTmL00RG2zF0GXTyEXEYY8Mte4yf7k2NxGfcPqFw/dX+TKoWqDQ/AwSTrOyfT
	 /XYyYz6SDjYMdOg/whQA+2Pg3/DLZo2Q5ey5vLps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfCHREr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCHREq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:04:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822A4205F4;
        Fri,  8 Mar 2019 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552064686;
        bh=3yOYRbBMPGsq0XJ7ErPVFh/TDFyNM/K59FU5669SGGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsWwJHfH0u9wN7k78y/jeX8cmChGSnBsCmMz8bkHBjJefnKCc/h4a5gtMEtaF4faU
         0GqhQ6xJJ5VOa+23Rzi8J56aVrzy9TDDFM2OsxO/e59bOOy94d9mz1ZLxwvrakDXz4
         6v0tMworCEkBQY0VGRpA5hoBy9yP3Um4oAUIy2dI=
Date:   Fri, 8 Mar 2019 14:39:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Read EC information on
 newer models
Message-ID: <20190308133944.GA22787@kroah.com>
References: <20190308131426.10254-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308131426.10254-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:14:26PM +0800, Jiaxun Yang wrote:
> Newer ThinkPads have a totally different EC program information DMI
> table. And thermal subdriver can't work without correct EC version.
> 
> Read from this entry if the old method failed to get EC information.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 62 ++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 13 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
