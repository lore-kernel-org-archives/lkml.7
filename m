Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9BCC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB40221019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562877304;
	bh=wr4Nj3jIOfdyWviMyXhQ+CMGFtDRtKAlzfEfmpu0Jh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rBs7CxF4XapiQq2engHfIoykvnRU7dbzBZRD97DdVpgiLXQUy3qf8KhwF4mY49SsW
	 DBXrQ9Kyz2n1rrcEJB6l5bgTFC+uOVpNueJmdkEJM4CgCRQX3qeRaME//69IvQeisX
	 jqfxGyDhdLezcB5QIl4tXW06qxC1l2JRAY4mydlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfGKUfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbfGKUfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:35:03 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B08206B8;
        Thu, 11 Jul 2019 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562877302;
        bh=wr4Nj3jIOfdyWviMyXhQ+CMGFtDRtKAlzfEfmpu0Jh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRIzRvwsmftb/ceVnExOvZg3ywhjm8ZQPH9HKoXObo7dCrBJjj+KD+1Gi0yKGRnZ2
         1h43xpnAXPi3RvnLeoK45+f2OJqoqKLSMqrTyMbyYd0qN1xvU8qH8IhgRuO4e0cKqY
         gGWcLqUKtRZwdziUheMOfDcHSbwIW1jDUb71oerw=
Date:   Thu, 11 Jul 2019 16:35:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
        solar@openwall.com, keescook@chromium.org, peterz@infradead.org,
        tyhicks@canonical.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: provide more information
 about linux-distros
Message-ID: <20190711203500.GB10104@sasha-vm>
References: <20190711163637.30327-1-sashal@kernel.org>
 <20190711170732.GB7544@kroah.com>
 <20190711170921.ywi43n262s3ckxpi@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190711170921.ywi43n262s3ckxpi@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 06:09:21PM +0100, Will Deacon wrote:
>On Thu, Jul 11, 2019 at 07:07:32PM +0200, Greg KH wrote:
>> On Thu, Jul 11, 2019 at 12:36:37PM -0400, Sasha Levin wrote:
>> > Provide more information about how to interact with the linux-distros
>> > mailing list for disclosing security bugs.
>> >
>> > First, clarify that the reporter must read and accept the linux-distros
>> > policies prior to sending a report.
>> >
>> > Second, clarify that the reported must provide a tentative public
>> > disclosure date and time in his first contact with linux-distros.
>> >
>> > Suggested-by: Solar Designer <solar@openwall.com>
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > ---
>> >  Documentation/admin-guide/security-bugs.rst | 21 +++++++++++++--------
>> >  1 file changed, 13 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
>> > index dcd6c93c7aac..c62faced9256 100644
>> > --- a/Documentation/admin-guide/security-bugs.rst
>> > +++ b/Documentation/admin-guide/security-bugs.rst
>> > @@ -61,14 +61,19 @@ Coordination
>> >
>> >  Fixes for sensitive bugs, such as those that might lead to privilege
>> >  escalations, may need to be coordinated with the private
>> > -<linux-distros@vs.openwall.org> mailing list so that distribution vendors
>> > -are well prepared to issue a fixed kernel upon public disclosure of the
>> > -upstream fix. Distros will need some time to test the proposed patch and
>> > -will generally request at least a few days of embargo, and vendor update
>> > -publication prefers to happen Tuesday through Thursday. When appropriate,
>> > -the security team can assist with this coordination, or the reporter can
>> > -include linux-distros from the start. In this case, remember to prefix
>> > -the email Subject line with "[vs]" as described in the linux-distros wiki:
>> > +<linux-distros@vs.openwall.org> mailing list so that distribution vendors are
>> > +well prepared to issue a fixed kernel upon public disclosure of the upstream
>> > +fix. As a reporter, you must read and accept the list's policy as outlined in
>> > +the linux-distros wiki:
>> > +<https://oss-security.openwall.org/wiki/mailing-lists/distros#list-policy-and-instructions-for-reporters>.
>> > +When you report a bug, you must also provide a tentative disclosure date and
>> > +time in your very first message to the list. Distros will need some time to
>> > +test the proposed patch so please allow at least a few days of embargo, and
>> > +vendor update publication prefers to happen Tuesday through Thursday. When
>> > +appropriate, the security team can assist with this coordination, or the
>> > +reporter can include linux-distros from the start. In this case, remember to
>> > +prefix the email Subject line with "[vs]" as described in the linux-distros
>> > +wiki:
>> >  <http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
>>
>> Do we really need to describe all of the information on how to use the
>> distro list here?  That's why we included the link, as it has all of
>> this well spelled out and described.  If anything, I would say we should
>> say less in this document about what linux-distros do, as that is
>> independent of the Linux security team.
>
>Agreed, and it also means that any changes linux-distros make to their
>policy won't be reflecting in the numerous kernel trees out there, so a
>link is much better imo.

I agree that the 2nd part about embargo timelines is redundant, but I
only addressed it because the document was already addressing embargos.

I only now realized that the link we had there was just going to the
main wiki page by mistake: the tag it was trying to point to was removed
from the wiki page. We should probably update that too.

With regards to the explicit instruction to agree with policies, I think
we do need it there. Right now this section reads as "for embargoes work
with linux-distros@vs.openwall.org, and btw they have a wiki which you
may or may not need to read".

We probably do need to stress here that linux-distros has different
policies than security@kernel.org.

--
Thanks,
Sasha
