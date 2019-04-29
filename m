Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D3FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB1C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfD2UOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:14:01 -0400
Received: from mail-n.franken.de ([193.175.24.27]:37114 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728928AbfD2UOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:14:01 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Apr 2019 16:14:00 EDT
Received: from perth.hirmke.de (aquarius.franken.de [193.175.24.89])
        (Authenticated sender: antares)
        by mail-n.franken.de (Postfix) with ESMTPSA id 4674E721E2825
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:04:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by perth.hirmke.de (Postfix) with ESMTP id EA52F9649F2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:04:14 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "Cc"
        occurs 6 times
Received: from perth.hirmke.de ([127.0.0.1])
        by localhost (perth.hirmke.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zclsxvBn1Dzt for <linux-kernel@vger.kernel.org>;
        Mon, 29 Apr 2019 22:04:13 +0200 (CEST)
Received: by perth.hirmke.de (Postfix, from userid 10)
        id 054139649D0; Mon, 29 Apr 2019 22:04:13 +0200 (CEST)
Received: by mike.franken.de (OpenXP/5.0.34 (Linux) (x86_64));
          29 Apr 2019 22:04:06 +0200
Date:   29 Apr 2019 22:03:00 +0200
From:   opensuse@mike.franken.de (Michael Hirmke)
To:     jslaby@suse.cz
Cc:     mika.westerberg@linux.intel.com
Cc:     bhelgaas@google.com
Cc:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Cc:     lukas@wunner.de
Cc:     tiwai@suse.de
Message-ID: <EkoOCx3N6GB@mike.franken.de>
In-Reply-To: <20190429195459.GU2583@lahna.fi.intel.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and thunderbolt)
User-Agent: OpenXP/5.0.34 (Linux) (x86_64)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline;
 modification-date="29 Apr 2019 20:03:39 +0000";
 read-date="Mon, 29 Apr 2019 22:03:39 +0200";
 creation-date="Mon, 29 Apr 2019 22:03:39 +0200"
Organization: Kommunikationsnetz Franken e.V. (Nuernberg)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

>On Mon, Apr 29, 2019 at 09:47:15PM +0200, Takashi Iwai wrote:
>> Hi,

>Hi,

>> we've got a regression report wrt xhci_hcd and thunderbolt on a Dell
>> machine.  5.0.7 is confirmed to work, so it must be a regression
>> introduced by 5.0.8.
>>
>> The details are found in openSUSE Bugzilla entry:
>>   https://bugzilla.opensuse.org/show_bug.cgi?id=1132943
>>
[...]
>>
>> I blindly suspected the commit 3943af9d01e9 and asked for a reverted
>> kernel, but in vain.  And now it was confirmed that the problem is
>> present with the latest 5.1-rc, too.
>>
>> I put some people who might have interest and the reporter (Michael)
>> to Cc.  If anyone has an idea, feel free to join to the Bugzilla, or
>> let me know if any help needed from the distro side.

>Since it exists in 5.1-rcX also it would be good if someone
>who see the problem (Michael?) could bisect it.

I know the meaning of bisecting, but I'm not really a developer, so I am
probably not able to interpret the results.

Sry.

Bye.
Michael.
-- 
Michael Hirmke
