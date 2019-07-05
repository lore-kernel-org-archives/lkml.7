Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23BC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE49C20836
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfGEKKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:10:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52868 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfGEKKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:10:02 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id be71f3d69a0f1914; Fri, 5 Jul 2019 12:10:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: ABI: power: Add missing newline at end of file
Date:   Fri, 05 Jul 2019 12:09:59 +0200
Message-ID: <7432234.XRVBgtUFqP@kreacher>
In-Reply-To: <20190701135827.23520-1-geert+renesas@glider.be>
References: <20190701135827.23520-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 1, 2019 3:58:27 PM CEST Geert Uytterhoeven wrote:
> "git diff" says:
> 
>     \ No newline at end of file
> 
> after modifying the files.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Split patches per maintainer.
> ---
>  Documentation/ABI/testing/sysfs-power | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index 18b7dc929234f625..3c51303550118474 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -300,4 +300,4 @@ Description:
>  		attempt.
>  
>  		Using this sysfs file will override any values that were
> -		set using the kernel command line for disk offset.
> \ No newline at end of file
> +		set using the kernel command line for disk offset.
> 

Applied, thanks!



