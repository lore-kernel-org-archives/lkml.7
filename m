Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4ECC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64946206DE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="s8B3vn/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbfIERIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:08:31 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:42001 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbfIERIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:08:31 -0400
Received: by mail-io1-f41.google.com with SMTP id n197so6433755iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=uFRmeqr4ImXzE2YrX6PwPkXowk12+Bgtqx8az+3QeJM=;
        b=s8B3vn/sw0hKicQLnoGbAzczXLHh0zknu3IXAjJWmChdcLzCzignHdddivGx1Fj0kj
         /D4GrVBMuFbyFQBZyafWTs/Eyv7le0hwjZmj0fonm6NGaeWipdWXvSU3DmYle6eE3uHN
         yGs9QNAMEa3/L9uFsg/2jkxTgBmgQBRpR6q54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=uFRmeqr4ImXzE2YrX6PwPkXowk12+Bgtqx8az+3QeJM=;
        b=ZdQZb9PzZm1xBmWfWd0/vnwx3eW54LfqmBu7ExftEH0TfPikL4oUgxdn8LL3SLM9KA
         tfRYSTbt222C1L3/0PrHUTgSCBKR9iNIsW4IjDiP29GiRBng1mamjBuSNJJHhhXPoqhY
         vV8fkrE16UOAnluMhyHDrT6eVkhQLSkmVM86Y4XIkf5OE5fztQcEnnqbU54dcxhs1Fop
         BiV+DoatCek5YOgYujEUIFZbid0Nc0+gWzMpJI5RKMYcoKWd5xo+pmXY99WyatJUwVx2
         /srQB6BR7T6FzeASHtg1anwoyvI7PNEBWZgdqrdeZ2qIXfLs1g0ChJixWqUQFHIfQ/zv
         JSAA==
X-Gm-Message-State: APjAAAWCzVAbKyMOA8gH8PzoBMHT3dhTOBvvatv0DEB63M/YTs7Jrnwr
        NMERPrR7T00IvOyWF9Wi5auiKg==
X-Google-Smtp-Source: APXvYqxPNqY25iZOGsF3Yc/WFp8cLpdVc2X/x4i/PAysDfU6fITl8EbcyM6u18QQyy7iblF/G814kA==
X-Received: by 2002:a5e:d90e:: with SMTP id n14mr5279937iop.29.1567703310144;
        Thu, 05 Sep 2019 10:08:30 -0700 (PDT)
Received: from [172.20.41.33] ([12.116.165.10])
        by smtp.gmail.com with ESMTPSA id m67sm4107925iof.21.2019.09.05.10.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:08:29 -0700 (PDT)
From:   Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Linux Foundation Technical Advisory Board Elections -- voting
 procedures
Date:   Thu, 5 Sep 2019 13:08:23 -0400
References: <0F702CB8-6D0C-4550-9EA7-EE86B4D96073@labbott.name>
To:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0F702CB8-6D0C-4550-9EA7-EE86B4D96073@labbott.name>
Message-Id: <C232C11A-D3FA-476C-8F71-58F675246D37@labbott.name>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 3, 2019, at 7:13 AM, Laura Abbott <laura@labbott.name> wrote:
>=20
> Hi,
>=20
> On behalf of the Linux Foundation Technical Advisory Board (TAB), I'd =
like to
> take this opportunity to announce the voting procedures for the 2019 =
TAB
> elections. As was announced[1], this year we are moving to electronic =
voting.
>=20
> Everyone who is registered for kernel summit (co-located with Linux =
Plumbers
> Conference in Lisbon this year) by September 8th 2019 is eligible to =
vote in
> this year's TAB elections. This includes everyone registered for =
Plumbers and
> Maintainers summit. All eligible voters will receive a link from
> Condorcet Internet Voting Service (https://civs.cs.cornell.edu) by the
> start of the first Plumbers session (September 9th 10am UTC+1). The =
voting
> will run until September 11th at 10am UTC+1.
>=20
> The list of all candidates and their platform is available at the =
following
> Google doc
>=20
> =
https://docs.google.com/document/d/1E3_W1c-xJMx9o2PCnKiGt3vqs-mPh77yNO4GSq=
NipOQ/edit?usp=3Dsharing
>=20
> We will also be hosting an open TAB session at Plumbers on Monday
> September 9th at 18:30. A more detailed FAQ about voting procedures is
> below.
>=20
> If you have any questions, feel free to reach out to
> tab@lists.linux-foundation.org .
>=20
> Thanks,
> Laura
>=20
> P.S. Please consider this a reminder to send in your TAB nominations!
>=20
> [1] =
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/0065=
82.html
>=20
> ---
>=20
> Q: Why are we making this change?
> A: As explained in the previous announcement,
> =
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/0065=
82.html
> In person voting has a number of limitations. We'd like to move to =
electronic
> voting with the objective of giving more members of our community a =
voice in
> the membership of the TAB
>=20
> Q: Who is eligible to vote?
> A: All registered attendees of Plumbers and Kernel Maintainers Summit =
are
> eligible.
>=20
> Q: If I am registered for Plumbers but not attending can I still vote?
> A: We will be sending the e-mail to all registered attendees before =
confirming
> they are present.
>=20
> Q: Can I register for Plumbers just to vote?
> A: Plumbers is sold out this year.
>=20
> Q: Why bother with electronic voting if the voting pool is still =
conference
> attendees?
> A: The kernel philosophy is small incremental changes. Based on =
discussions
> with the TAB, changing the voting method and widening the voting pool
> simultaneously was too much for one year. The goal is to run the =
electronic
> voting this year with the same voting pool and then discuss how voting =
will
> work in subsequent years.
>=20
> Q: When does voting start?
> A: E-mails with the voting link will be sent out before the start of =
the
> first Plumbers session on Monday September 9th at 10am UTC+1
>=20
> Q: When does voting end?
> A: Voting ends on September 11th at 10am UTC+1
>=20
> Q: What's the software used for voting?
> A: We will be using the hosted version of the Condorcet Internet =
Voting Service
> (CIVS) at https://civs.cs.cornell.edu
>=20
> Q: Is this code open source?
> A: Yes. The code is available under a BSD-like research license
>=20
> Q: How do I vote?
> A: You will receive an e-mail by Monday September 9th at 10am UTC+1 =
with
> a link to vote.
>=20
> Q: Is this method of voting secure?
> A: Privacy and security is a focus of CIVS. See
> https://civs.cs.cornell.edu/sec_priv.html for more information.
>=20
> Q: The website mentions ranked choice voting. What is this?
> A: In ranked choice voting, you rank your preferred choices from most
> to least liked. The theory is this results in a more accurate =
representation
> of what the voter pool wants. This is a different method than we've =
used
> for TAB elections in the past where you indicated your preferred $n =
out
> of $m candidates. Because we are using the hosted version of CIVS, we =
did
> not have the option to use our old method of voting.
>=20
> Q: The description mentions an 'election supervisor'. What is this =
role?
> A: The election supervisor's role is to start and stop the poll, send
> links to voters, and set various options for the poll. A single e-mail
> address is used to e-mail the link to manage the election, after which
> anyone with the link can manage the poll.
>=20
> Q: Who is the election supervisor for the TAB elections?
> A: We have created a mailing list for election management. This =
mailing
> list contains individuals from the kernel community who are not =
running
> for the TAB this year, similar to in-person proctors from past years.
> We are still working on getting the mailing list set up, the address =
will
> be announced when it is ready.
>=20
> Q: What if I lose the e-mail before I vote?
> A: Please e-mail the election list, address to be announced
>=20
> Q: What if I want to change my vote?
> A: This is not possible, please make sure you've made your final =
choices
> when you click submit.
>=20
> Q: What if I want to practice voting?
> A: CIVS has a number of sample polls available. Feel free to vote in =
those
> to see how the process works.
>=20
> Q: What if something unforeseen happens with electronic voting and we =
don't
> end up with results?
> A: We will arrange an in person vote similar to previous years.
>=20
> Q: What if I have questions not addressed here?
> A: E-mail tab@lists.linuxfoundation.org for the current Technical =
Advisory
> Board or the election list, address to be announced
>=20

The mailing list for questions about elections is =
tab-elections@lists.linuxfoundation.org

