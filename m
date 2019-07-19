Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66096C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2637E2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="U+KC5WsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGSJyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:54:36 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:36045 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbfGSJyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:54:36 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 45qmZ22cmTz8tyn;
        Fri, 19 Jul 2019 11:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1563530074; bh=vjzwfrsZLlSIbtd5eSy2DYay8uWmG1SrcA5Ds2pFh5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From:To:CC:
         Subject;
        b=U+KC5WsMgwEaXEuOtbiQi73BOsaAaxIXs87idiZAvVOS40IZ/ps5RYbxA/S973MqW
         4Miov5zVvCtfVSgGMiQ+paaQcKhw6g1Fdt4GtsK5K3onHpJ3zS69tkGTxzXVJ9ksLD
         W6CP7Nev4K61KqTPp3a0SwYdpsxGcuR5d2mXTM9VQX5u7XWk48YappZdTLNK/kysjH
         5NknyoJzVIIkbuvdxr+oWwU2FTT4fCbee+jQ6fhYBplzDEXFRjdHG269NOgYopZZZi
         daROjWo12n3hTfosZtTao5gJPP6Jkd7gs45p8THDLZEDnIQyrnb2BeMU1Muoi9pNul
         SRvpl2msAGBYQ==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.11.37
Received: from faumail.fau.de (smtp-auth.uni-erlangen.de [131.188.11.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+o9vEh2Jou6TkmBuoRZQ9o6xSeip4AJoc=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 45qmYz61rHz8vVf;
        Fri, 19 Jul 2019 11:54:31 +0200 (CEST)
Received: from a9s8n9g3ZvFv9dr7Wf3V4Af4x10BG5ViOwLef9n3hxU=
 by faumail.uni-erlangen.de
 with HTTP (HTTP/1.1 POST); Fri, 19 Jul 2019 11:54:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Jul 2019 09:54:31 +0000
From:   "Duda, Sebastian" <sebastian.duda@fau.de>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        ralf.ramsauer@oth-regensburg.de, wolfgang.mauerer@oth-regensburg.de
Subject: Re: get_maintainers.pl subsystem output
In-Reply-To: <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
 <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
Message-ID: <6fa4aa44f343616459b17054197d0a22@fau.de>
X-Sender: sebastian.duda@fau.de
User-Agent: Roundcube Webmail/1.2.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-19 08:50, Joe Perches wrote:
> On Fri, 2019-07-19 at 07:35 +0000, Duda, Sebastian wrote:
>> Hi Joe,
>> 
>> I'm conducting a large-scale patch analysis of the LKML with 1.8 
>> million
>> patch emails. I'm using the `get_maintainer.pl` script to know which
>> patch is related to which subsystem.
> 
> The MAINTAINERS file is updated frequently.
> 
> Are you also using the MAINTAINERS file used
> at the time each patch was submitted?

Yes, for each patch we use the MAINTAINERS file from the current (by the 
time the patch was submitted) release (candidate).

>> I ran into two issues while using the script:
>> 
>> 1. When I use the script the trivial way
>> 
>>      $ scripts/get_maintainer.pl --subsystem --status --separator ,
>> drivers/media/i2c/adv748x/
>>      Kieran Bingham <kieran.bingham@ideasonboard.com> 
>> (maintainer:ANALOG
>> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org>
>> (maintainer:MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC
>> ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
>>      Maintained,Buried alive in reporters
>>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB),THE REST
>> 
>> the output is hard to parse because the status `Maintained` is 
>> displayed
>> only once but related to two subsystems.
>> 
>> I'd prefer a more table like representation, like this:
>> 
>>      Kieran Bingham <kieran.bingham@ideasonboard.com> 
>> (maintainer:ANALOG
>> DEVICES INC ADV748X DRIVER),linux-media@vger.kernel.org (open
>> list:ANALOG DEVICES INC ADV748X DRIVER),ANALOG DEVICES INC ADV748X
>> DRIVER,Maintained
>>      Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA 
>> INPUT
>> INFRASTRUCTURE (V4L/DVB)),MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB),Maintained
>>      linux-kernel@vger.kernel.org (open list),THE REST,Buried alive in
>> reporters
>> 
>> 
>> 2. I want to analyze multiple patches, currently I am calling the 
>> script
>> once per patch. When calling the script with multiple files the files
>> output is merged
>> 
>>      $ scripts/get_maintainer.pl --subsystem --status --separator ','
>> drivers/media/i2c/adv748x/ include/uapi/linux/wmi.h
>>      Kieran Bingham <kieran.bingham@ideasonboard.com> 
>> (maintainer:ANALOG
>> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org>
>> (maintainer:MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC
>> ADV748X DRIVER),linux-kernel@vger.kernel.org (open
>> list),platform-driver-x86@vger.kernel.org (open list:ACPI WMI DRIVER)
>>      Maintained,Buried alive in reporters,Orphan
>>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB),THE REST,ACPI WMI DRIVER
>> 
>> I'd like to run the script with all files but separated output, like
>> this:
>> 
>>      $ scripts/get_maintainer.pl --subsystem --status --separator ','
>> --separate-files drivers/media/i2c/adv748x/ include/uapi/linux/wmi.h
>>      Kieran Bingham <kieran.bingham@ideasonboard.com> 
>> (maintainer:ANALOG
>> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org>
>> (maintainer:MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC
>> ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
>>      Maintained,Buried alive in reporters
>>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB),THE REST
>> 
>>      platform-driver-x86@vger.kernel.org (open list:ACPI WMI
>> DRIVER),linux-kernel@vger.kernel.org (open list)
>>      Orphan,Buried alive in reporters
>>      ACPI WMI DRIVER,THE REST
>> 
>> 
>> My Questions are:
>> 1. How can I make get_maintainer's output to be more table-like?
> 
> I suggest adding --nogit --nogit-fallback --roles --norolestats

Unfortunately, this doesn't change the output:
     $ scripts/get_maintainer.pl --subsystem --status --separator , 
drivers/media/i2c/adv748x/
     Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
(maintainer:MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
     Maintained,Buried alive in reporters
     ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB),THE REST

     $ scripts/get_maintainer.pl --subsystem --status --separator , 
--nogit --nogit-fallback --roles --norolestats 
drivers/media/i2c/adv748x/
     Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
(maintainer:MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
     Maintained,Buried alive in reporters
     ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB),THE REST

>> 2. How can I make get_maintainer.pl to separate each file's output?
> 
> Run the script with multiple invocations. once for each file
> modified by the patch.

This is the way I'm doing it right now but this is very slow. I thought 
calling the script only once for many files could speed up the analysis.

Thank you
Sebastian
