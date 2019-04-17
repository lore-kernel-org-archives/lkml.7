Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A16C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911EB206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfDQMHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:07:50 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37531 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbfDQMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:07:49 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BDB7EE0003;
        Wed, 17 Apr 2019 12:07:44 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Nicholas Mc Guire <der.herr@hofr.at>, Andrew Lunn <andrew@lunn.ch>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH V2] ARM: mvebu: at least report the kzalloc failure
In-Reply-To: <20190417114228.GA20280@osadl.at>
References: <1555386991-8855-1-git-send-email-hofrat@osadl.org> <20190416133957.GB29190@lunn.ch> <20190417114228.GA20280@osadl.at>
Date:   Wed, 17 Apr 2019 14:07:44 +0200
Message-ID: <877ebsal7z.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

Nicholas Mc Guire <der.herr@hofr.at> writes:

> On Tue, Apr 16, 2019 at 03:39:57PM +0200, Andrew Lunn wrote:
>> On Tue, Apr 16, 2019 at 05:56:31AM +0200, Nicholas Mc Guire wrote:
>> 
>> > Note that this will trigger a checkpatch WARNING
>> > "WARNING: Possible unnecessary 'out of memory' message"
>> > but comparing the oops with an without the one-line pr_err I would
>> > argue that it makes sense to include it:
>> 
>> Hi Nicholas
>> 
>> It might be worth adding this as a comment, so that newbies don't
>> submit patches removing the pr_err() because of the checkpatch
>> warning.
>>
> hmm... I think if we start doing that we would make quite a mess of
> documentation in the kernel. Also note its a warning stating "possible 
> unneceessary" - so I would not see the necessity.
>
> At most I would include a note on this in the commit message so that
> anyone checking the origin would see that this is intenttional - assuming
> that people modifying code would be using git blame to locate the
> origin of any code...

Don't bother to send a new version I don't attempt to take this
patch. As you pointed it is very unlikely that we get an error so early
during the boot for a very small amount of memory.

If it happened then we have serious trouble and the message provided by
the BUG() call will be more than enough.

Thanks,

Gregory


>
> thx!
> hofrat
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
