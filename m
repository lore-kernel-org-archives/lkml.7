Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D33C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 04:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7552208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 04:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="EHIOyz6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfEMEnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 00:43:20 -0400
Received: from mx1.cock.li ([185.10.68.5]:45675 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbfEMEnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 00:43:20 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557722595; bh=jKZ6KMdNdQ581vz5QNzdIMdfzhuv0J37HqPVJEZgdfA=;
        h=Date:From:To:Cc:Subject:From;
        b=EHIOyz6/WlQfhVzO4rZBkIHnByXQUwhFQ5N5o3JF+LdNqfF2FBKn73JIdrhsiLnup
         X1qrqSjYCN3jIWSvzjETb7wMoAVD9YlqUkNiF3rsq7L9GhLfxOPAW+vbNiRCxXJ8ox
         KzQ8t+V4UKSxK79f66iYJr8gO9p3pmrMvoatAqiACcXTyeuVZrQPsZvUVJ5Iaq57lN
         Czk+9Nhm07iMxnJ/OVNLrepTM550IWECfpoGaP8i/q+km2VhO7R3GxW/odnRGo5qW9
         8ruLLomjvp4E0o4CQH3qEhRKKNXsh0yHrzKjqZpKY2M6Rma0NFp9LouEqOK+5vyVjr
         Ur4fmv6zU5y2w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 May 2019 04:43:15 +0000
From:   informator@redchan.it
To:     antoine.thomas@prestashop.com
Cc:     linux-kernel@vger.kernel.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, license-discuss-owner@lists.opensource.org,
        freebsd-current@freebsd.org
Subject: [License-discuss] Can a contributor take back open source code ? -
 Yes, if he has not signed over the copyright.
Message-ID: <b9586de411c283af2f4f2132b174d537@redchan.it>
X-Sender: informator@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a "not easy" question: is it possible for a contributor to 
> remove his contributions (code, translations, ...) from an open source 
> project?

In short: Yes the copyright holder can do just that in most cases we see 
in the wild (where there is no copyright assignment and the licensees 
are free-takers).

It seems to the policy of the FSF, SFLC, etc to claim to you that 
Illusory Promises are enforceable in the US courts, or to claim that 
obeying a preexisting legal duty is valid consideration for a mutually 
enforceable agreement (contract). Obviously you have an inkling to the 
contrary since you are asking this question. Your suspicion is well 
founded, as consideration, contrary to what interested parties may want 
you to believe, is still generally a requirement for a promise to be 
held enforceable, in the US.

-----

Assuming: Contributor has not signed over his copyrights, and the entity 
did not pay consideration to the "contributor":

Yes.

Free Non-exclusive licenses are revocable.

For a promise not to revoke or to revoke only under certain 
circumstances to be binding against the grantor he must have received 
some bargained-for consideration in exchange.

"Nothing" is not valid consideration.

Offering what you are trying to contract for as "consideration" for that 
very contract is not valid consideration.

Obeying a pre-existing legal duty (not violating the copyright holder's 
copyright) is not valid consideration.

You can read a lengthy explanation for the lay person here:
lkml.org/lkml/2019/5/3/698
(and it covers the 9th circuit
Artifex case and 9th circuit Artistic License case which some people
will try to make you think invalidates your proprietary rights)
or here:
lkml.org/lkml/2019/5/4/334


Note: If you would like a nice expansive legal paper to read on this
issue, Sapna Kumar's paper is good:
scholarship.law.duke.edu/faculty_scholarship/1857/
www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
papers.ssrn.com/sol3/papers.cfm?abstract_id=243237


> And, if someone do that, is it possible for the project to continue to 
> maintain the previous version, thanks to the license? (I mean, before 
> the deletion)

No. Once the license is revoked, if the licensee cannot show that it has 
an attached interest (ie: a valid contract), by law the licensee 
no-longer has permission from the copyright owner to 
use/distribute/modify/etc the work of authorship. They may beg the court 
under equity for some accommodation, of course.


