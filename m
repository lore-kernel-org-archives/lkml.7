Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C1C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC182087F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="YQzSM5Z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfEERnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 13:43:49 -0400
Received: from mx1.cock.li ([185.10.68.5]:46415 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbfEERnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 13:43:49 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557078224; bh=DJdHE0u5O0yorihys3d6p/PvPl9ahLoEF/nRpxntjlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQzSM5Z5vY/vUEAba8K8XQDzZVkVI6VfgiMHh8+yzeOrQOsayjHAxG8GqnQdD6UVZ
         wo1FEgeLpgJ4t2YRsJ4ufW3C0tk8tLy2QKrrPvtJeiZVgEabSIbWATJP7LOBe8EIN2
         uN1r5h52RwT4ocJRyXcOPtcK7em4Xqa+yuxQysQZmysXZYODVixhQAR1zRR+MaAf0w
         BhzDbh1aerTL5hUBNoY5WkkIDa1Cu8vn4mntKj8bGeIajUIMB56VVE9hZD6zg1KCep
         b1qo/pV6Hf4ZOmtVOijNTTU6Y1FpunWA6+FVeX9oVbukgkZhS9IyOLOaGtt9Pb1hMg
         4rA811lGf16CA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 05 May 2019 17:43:44 +0000
From:   vsnsdualce2@redchan.it
To:     rhkramer@gmail.com
Cc:     debian-user@lists.debian.org, linux-kernel@vger.kernel.org,
        Ivan Ivanov <qmastery16@gmail.com>, mailinglists@mattcrews.com,
        jhasler@newsguy.com, scdbackup@gmx.net, richard@walnut.gen.nz,
        curty@free.fr, jmtd@debian.org, mick.crane@gmail.com,
        tomas@tuxteam.de, steve@einval.com, joe@jretrading.com,
        rms@gnu.org, esr@thyrsus.com
Subject: Re: Can a recipients rights under GNU GPL be revoked? - Bradley M.
 Kuhn is not an attorney (he should go get his JD and get licensed).
In-Reply-To: <201905050807.51462.rhkramer@gmail.com>
References: <60c1b08305c5326e3503f51d81622541@redchan.it>
 <201905050807.51462.rhkramer@gmail.com>
Message-ID: <7075ee948a62ed059fb713b53e4e0c35@redchan.it>
X-Sender: vsnsdualce2@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhkramer@gmail.com:

https://www.americanbar.org/groups/professional_responsibility/publications/model_rules_of_professional_conduct/rule_5_4_professional_independence_of_a_lawyer/

(Most state bar associations implement this or similar)



(b) A lawyer shall not form a partnership with a nonlawyer if any of the 
activities of the partnership consist of the practice of law.
...
(d) A lawyer shall not practice with or in the form of a professional 
corporation or association authorized to practice law for a profit, if:

(1) a nonlawyer owns any interest therein, except that a fiduciary 
representative of the estate of a lawyer may hold the stock or interest 
of the lawyer for a reasonable time during administration;

(2) a nonlawyer is a corporate director or officer thereof or occupies 
the position of similar responsibility in any form of association other 
than a corporation ; or

(3) a nonlawyer has the right to direct or control the professional 
judgment of a lawyer.

Steve McIntyre Wrote:
> It's just bullshit trolling. Multiple different From: addresses, all
> sent via cock.li. Easily blocked/ignored.

> --
> Steve McIntyre, Cambridge, UK.                                
> >steve@einval.com
> There's no sensation to compare with this
> Suspended animation, A state of bliss

How about you shut you fucking mouth about professions you are not 
involved in?

Free licenses are revocable. They are simply permission and not backed 
by any bargained-for consideration. Weather you like it or not, Weather 
it gets you "mad" or not.



On 2019-05-05 12:07, rhkramer@gmail.com wrote:
> On Sunday, May 05, 2019 12:51:15 AM vsnsdualce2@redchan.it wrote:
>> Bar rules do not allow lawyers to serve under a non-lawyer
>> in
>> an organization, and the organization was essentially a pro-bono law
>> firm
>> (which really needed a attorney in it's ranks...)
> 
> That's interesting, but (off the point of this email exchange), it 
> puzzles me
> -- many corporations headed by non-lawyers have lawyers on staff, so 
> I'm
> guessing that the statement you made applies only to organizations like 
> law
> firms, or, the lawyers on the staff of a non-law corporation are in
> something at
> least a little different than the normal employer / employee 
> relationship.
> 
> (PS: I stand corrected on Kuhn being a lawyer -- thanks for the 
> correction.)
> 
> Now I have to debate (with myself) whether to prune the cc list -- I 
> forget
> the original post -- was it really this widespread?
