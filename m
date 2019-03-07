Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLACK,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DDAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC6D20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551957648;
	bh=28TrtKwy4SnlYII2jUKRp7Ft2/hQ548/HfCqpAuyYFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y6gT3MhKJw57FJe1W1lV10e5z5TtAqt3oIdrqU2R9qUXLryPtmUBaKbPDKkkOr0dB
	 TnxSuglUXOp7o3MHDM31zi7qEsPon54JnHY/Dza43SJeA/81ek5GRgmiQiHIgmqtgV
	 rdTSwHmWBdMb5zW7NA/6nkfK1qkGDfbCWS3lTRIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCGLUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:20:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfCGLUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:20:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE5420675;
        Thu,  7 Mar 2019 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551957643;
        bh=28TrtKwy4SnlYII2jUKRp7Ft2/hQ548/HfCqpAuyYFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EgSum1JrqRLveFvqojt8v1Cu5iiok+wgEbwg3LWi5Km7n+f7MOZi6GmWmejtsXxCn
         PbHNKaC2+q3V2zx7BnIIDZ9gr4wD/xX2FXIEEQLP/X1F8m0nQHmw+ixmBboTdRVJQ5
         HfB0334/rQlvBKz6BOzNTGh/h+JohZX6vNYqdxPM=
Date:   Thu, 7 Mar 2019 12:20:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
 machines
Message-ID: <20190307112041.GC13633@kroah.com>
References: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 04:08:20PM +0800, Jiaxun Yang wrote:
> Some AMD based ThinkPads have a firmware bug that calling
> "GBDC" will cause bluetooth on Intel wireless cards blocked.
> 
> Probe these models by DMI match and disable bluetooth subdriver
> if specified Intel wireless card exist.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 70 ++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
