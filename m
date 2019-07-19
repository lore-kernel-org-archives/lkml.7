Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6192AC7619A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3622184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563507681;
	bh=fGenb1Mo2TQisp4uP/EkQQBPHk9tuT2DgTBPWSW/Zsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UbJn9R3Rr7pS/IrxSmmLERzka0nCke9P6ew8BqbJ+ov3fyLiBjB2//ouGaoB+/Sp/
	 rhfkCCn/IkJ53Q3uAiz2Lfo0rnIp/ZmLjrscJU51VWRtqCIxgX4beBjvfIPfSzkF3T
	 V4MQriEZ+1bURxlCP7g/hxQUuEiYJKDIjQgKRlFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGSDlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGSDlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:41:16 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DAF62173B;
        Fri, 19 Jul 2019 03:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563507674;
        bh=fGenb1Mo2TQisp4uP/EkQQBPHk9tuT2DgTBPWSW/Zsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idvmJqXg+JMJL13zM+eQc6WBWK73ywhbWBURHgDuVkhBIafYZGFfF68P+Rj1mfAeJ
         NmihOb5H26CPilkCB88yPRVo+3+yfAossIppQ3jPNaxVZy+d0Dt5kTEVIZVyyboSOM
         ESfa3IiiiRlVO54Ft6UQee6w0FSEM+BbdbRyLw2w=
Date:   Thu, 18 Jul 2019 23:41:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, solar@openwall.com, will@kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/security-bugs: provide more information
 about linux-distros
Message-ID: <20190719034113.GD4240@sasha-vm>
References: <20190717231103.13949-1-sashal@kernel.org>
 <201907181457.D61AC061C@keescook>
 <20190719003919.GC4240@sasha-vm>
 <201907181833.EF0D93C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <201907181833.EF0D93C@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 06:51:07PM -0700, Kees Cook wrote:
>On Thu, Jul 18, 2019 at 08:39:19PM -0400, Sasha Levin wrote:
>> On Thu, Jul 18, 2019 at 03:00:55PM -0700, Kees Cook wrote:
>> > On Wed, Jul 17, 2019 at 07:11:03PM -0400, Sasha Levin wrote:
>> > > Provide more information about how to interact with the linux-distros
>> > > mailing list for disclosing security bugs.
>> > >
>> > > Reference the linux-distros list policy and clarify that the reporter
>> > > must read and understand those policies as they differ from
>> > > security@kernel.org's policy.
>> > >
>> > > Suggested-by: Solar Designer <solar@openwall.com>
>> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> >
>> > Sorry, but NACK, see below...
>> >
>> > > ---
>> > >
>> > > Changes in v2:
>> > >  - Focus more on pointing to the linux-distros wiki and policies.
>> >
>> > I think this is already happening in the text. What specifically do you
>> > want described differently?
>>
>> The main issue was that there isn't anything pointing to the
>> linux-distros policies. The current text outlines a few of them ("add
>> [vs]", and "there should be an embargo period"), but it effectively just
>> gives out the linux-distros mailing address and tells the reporter to
>> contact it.
>
>The current text includes the wiki link, but yes, the anchor tag is not
>present at the wiki anymore. I would agree that's due for updating.
>
>I think reinforcing information to avoid past mistakes is appropriate
>here. Reports have regularly missed the "[vs]" detail or suggested
>embargoes that ended on Fridays, etc.

Right, but this is a sign that the reporter didn't read the wiki.
Explaining things like this encourages reporters to skip reading the
wiki and just send their report out.

>> > >  - Remove explicit linux-distros email.
>> >
>> > I don't like this because we had past trouble with notifications going
>> > to the distros@ list and leaking Linux-only flaws to the BSDs. As there
>> > isn't a separate linux-distros wiki, the clarification of WHICH list is
>> > needed.
>>
>> Why would removing the explicit linux-distros email encourage people to
>> send reports to it?
>
>What? No, I'm saying we should _keep_ linux-distros@... in our text so
>that people don't send to the wrong list.

But doesn't this just encourage mails being sent to linux-distros@
without the policies being followed? That was Alexander's concern at
least.

>> I also don't understand what you mean by "there isn't a separate
>> linux-distros wiki"? There is one, and I want to point the reporter
>> there.
>
>That URL is a combined page for two lists. The very fact that it's
>not obvious that there are two lists described there is exactly why I
>think we need to keep an explicit mention of which to use. There are
>two mailing lists described at the wiki URL:
>
>	      distros@lists.openwall.com
>	linux-distros@lists.openwall.com
>
>Sending to the distros@ list risks exposing Linux-only flaws to non-Linux
>distros. This has caused leaks in the past, and we do not want people
>guessing at which list they should use.
>
>Also note that nowhere on the openwall wiki is the email address
>actually spelled out; this is another reason to spell it out in our
>documentation: no misunderstanding.
>
>(And historically there WAS a specific linux-distros wiki:
>https://oss-security.openwall.org/wiki/mailing-lists/linux-distros
>but it redirects to the combined one now...)
>
>> > >  - Remove various explanations of linux-distros policies.
>> >
>> > I don't think there's value in removing the Tue-Thu comment, nor
>> > providing context for why distros need time. This has been a regular
>> > thing we've had to explain to researchers that aren't familiar with
>> > update procedures and publication timing.
>>
>> To be fair, the Tue-Thu comment is listed in the section describing how
>> to do coordination with linux-distros, and linux-distros don't have a
>> Tue-Thu policy. If it's a security@kernel.org policy then let's list it
>> elsewhere.
>
>It's a distro preference. Many researchers aren't thinking about the
>larger Linux ecosystem that has to consume fixes. It's not a _policy_,
>but it makes the researchers understand how to construct better embargoes.

If it's an accepted preference then we should just document it in a few
other places like the linux-distros@ wiki. My concern with this is that
it's not, and it's actually one of the only things Alexander pointed out
in this document as surprising.

--
Thanks,
Sasha

>> If you feel that there is a consensus around Tue-Thu let's just add it
>> to the linux-distros policy wiki, there's no point in listing random
>> policies from that wiki.
>
>I think it'd be a good idea to add that note also to the wiki, but I
>don't want it removed from our text because I have had to repeat that
>information regularly in the past.
>
>-- 
>Kees Cook
