Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F8ECA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2DB208CB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="TdyK6ftc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfKBAsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:48:30 -0400
Received: from mx1.cock.li ([185.10.68.5]:54043 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfKBAsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:48:30 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1572655705; bh=q5GnTzAglDVLZVNwokGYpKpvnvZNg5pNuSSM0u+V7Zs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TdyK6ftcpEKRAekW7yQRLB3R3w7Fwhdc6VuL/fbzIdTEdC2yt58cIqLXo7TkSftcQ
         Ys6u0Qrtg+82W3AUfsmO69o/w9CODihHw0qPkqT7FwHmhH1HvP45XfljWtWMbCFYnD
         IA/g0JwlJ526TjvA2jfKhNSK5wtRb8ag+SpYCx463FAGt9I3qhV/HsBDUD4lOcHutW
         0Za0miri62owmbVKF4/AP6HokrqJfojejuzTagw5B0JpmLSDHwWz9zAjaqNDl398xj
         cvnQdcLLYUzoLbukX8QZ7gchREfVKfLAUcaMbwck+k7/IB8GolX6jUX4XZ3YkEQEqE
         nudMPrJh2Rpnw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 02 Nov 2019 00:48:25 +0000
From:   gameonlinux@redchan.it
To:     Jean Louis <bugs@gnu.support>
Cc:     gnu-system-discuss@gnu.org, bruce@perens.com, rms@gnu.org,
        esr@thyrsus.com, torvalds@linux-foundation.org, ams@gnu.org,
        linux-kernel@vger.kernel.org
Subject: Re: (Censored) Why will no-one sue GrSecurity for their blatant GPL
 violation (of GCC and the linux kernel)?
In-Reply-To: <20191101070258.GK3889@protected.rcdrun.com>
References: <e3a6a2070e2182be00b9720b4a1c591f@redchan.it>
 <20191101070258.GK3889@protected.rcdrun.com>
Message-ID: <b07b73864b9e65d220437f38d7ad746e@redchan.it>
X-Sender: gameonlinux@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a law license, I don't need to read about who has standing to 
sue, and how to do so (Copyright Litigation (COPYLITG on Westlaw) is 
good enough for that).

I want to know why you guys (Fsf for the GCC plugins, and various kernel 
copyright holders for the kernel patch) will not sue GrSecurity, and why 
there is no discussion.

You just won't discuss this blatant foundational violation.

Why has my post been spam filtered/black holed.

On 2019-11-01 07:02, Jean Louis wrote:
> * gameonlinux@redchan.it <gameonlinux@redchan.it> [2019-11-01 00:03]:
>> I tried to send this to the list, but it was dropped as spam, which is 
>> no
>> surprise since the some want to screen communications to RMS and thus
>> control him.
> 
> ... cut...
> 
>> Wouldn't the FSF have standing regarding the GCC plugins atleast?
>> Couldn't you all rally linux-kernel copyright holders to bring a joint
>> action?
>> 
>> References:
>> perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/
>> 
>> perens.com/static/OSS_Spenger_v_Perens/0_2018cv15189/docs1/pdf/18.pdf
>> (Page 10 onward of this brief gives a good recitation of the facts and
>> issues
> 
> Recommended reads:
> 
> Enforcing the GNU GPL by Eben Moglen
> https://www.gnu.org/philosophy/enforcing-gpl.html
> 
> and
> 
> The Principles of Community-Oriented GPL Enforcement by Joshua Gay
> https://www.fsf.org/licensing/enforcement-principles
> 
> Jean
