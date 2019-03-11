Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37540206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCKMAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:00:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43723 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfCKMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:00:32 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 165a14df60f51432; Mon, 11 Mar 2019 13:00:29 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: acpi: fix path for acpidbg tool
Date:   Mon, 11 Mar 2019 12:58:46 +0100
Message-ID: <2066889.Es8ADf5CTK@aspire.rjw.lan>
In-Reply-To: <1551437591-11022-1-git-send-email-f.suligoi@asem.it>
References: <1551437591-11022-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 1, 2019 11:53:11 AM CET Flavio Suligoi wrote:
> The file:
> 
> Documentation/acpi/aml-debugger.txt
> 
> reports an obsolete path for the acpidbg tool.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  Documentation/acpi/aml-debugger.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
> index e851cc5..75ebeb6 100644
> --- a/Documentation/acpi/aml-debugger.txt
> +++ b/Documentation/acpi/aml-debugger.txt
> @@ -23,7 +23,7 @@ kernel.
>  
>     The resultant userspace tool binary is then located at:
>  
> -     tools/acpi/power/acpi/acpidbg/acpidbg
> +     tools/power/acpi/acpidbg
>  
>     It can be installed to system directories by running "make install" (as a
>     sufficiently privileged user).
> @@ -35,7 +35,7 @@ kernel.
>  
>     # mount -t debugfs none /sys/kernel/debug
>     # modprobe acpi_dbg
> -   # tools/acpi/power/acpi/acpidbg/acpidbg
> +   # tools/power/acpi/acpidbg
>  
>     That spawns the interactive AML debugger environment where you can execute
>     debugger commands.
> 

Applied, thanks!


