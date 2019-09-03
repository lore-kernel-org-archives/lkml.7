Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0791022CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="CMcmgs9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfICLNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:13:40 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42665 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfICLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:13:39 -0400
Received: by mail-qk1-f182.google.com with SMTP id f13so15372785qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=zqa5ZMLg0fTI0pF6DzPr1eutA6vpO+UEVuYus/lDOoA=;
        b=CMcmgs9c+iCw/yRz3Soop0t5AUQ4tQIVaLTG8v5tKG0a9oxTpjZiEro2kwSloeSIwr
         Px6PFMXTaSoEIxYL+Pg6SDrOgE7PpcCSAFrNUT2BgHWk8NOWXTX8iLuqKqETbjwQnPnf
         PfppGc37B6voAw/6dGrsHSyIDcFcxhgoVlo7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=zqa5ZMLg0fTI0pF6DzPr1eutA6vpO+UEVuYus/lDOoA=;
        b=Qi4o7Ev138B8p5zeZCPWng2vZtO2LwXQFb/qrQs9eLfRRs7ukrjhWFwwd07UOKADDs
         F4VgJYa5nWRtDLCTbetgqpKw0AjooIIwJqq45tPhUpX9I2s5gY4TrVQKdCMctozh2RXb
         wo5dpDUNsqdZhLsugIanH84Wq9dSYav8lMvTfm9mKTebl1jkB6X980zCpdkHQ0vTpiEb
         cp4g1MUB8Rqhch2eoREEGNfuJu+L2fO/ajwNpAll/7d03ggHfyWPzOHkAlvP2chY+/TZ
         EZuZLuu6uj9uuS8xEy3M11s7utvFL9+GA00kJxnYEAknF0mUAgHyov0m1XMEJhjWvxZi
         83UQ==
X-Gm-Message-State: APjAAAUCFmiSvlgSRSzQ8AA4BgTHM3AYPGVY9QbJVQ+Zsh1N6/8UYW18
        xix5MFOvUQNBpb6GxEPPwToRkg==
X-Google-Smtp-Source: APXvYqzmLayJMlPuCRIgPHEUCQ4W91/FlleWSrkz6X2HOJKcQBiuz9FsQPb/5JScnEAsbcDVYeOnCw==
X-Received: by 2002:a05:620a:1283:: with SMTP id w3mr27431681qki.237.1567509218295;
        Tue, 03 Sep 2019 04:13:38 -0700 (PDT)
Received: from [172.20.4.210] ([64.196.201.104])
        by smtp.gmail.com with ESMTPSA id u39sm7881457qtj.34.2019.09.03.04.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 04:13:37 -0700 (PDT)
From:   Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Linux Foundation Technical Advisory Board Elections -- voting
 procedures
Message-Id: <0F702CB8-6D0C-4550-9EA7-EE86B4D96073@labbott.name>
Date:   Tue, 3 Sep 2019 07:13:35 -0400
To:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On behalf of the Linux Foundation Technical Advisory Board (TAB), I'd =
like to
take this opportunity to announce the voting procedures for the 2019 TAB
elections. As was announced[1], this year we are moving to electronic =
voting.

Everyone who is registered for kernel summit (co-located with Linux =
Plumbers
Conference in Lisbon this year) by September 8th 2019 is eligible to =
vote in
this year's TAB elections. This includes everyone registered for =
Plumbers and
Maintainers summit. All eligible voters will receive a link from
Condorcet Internet Voting Service (https://civs.cs.cornell.edu) by the
start of the first Plumbers session (September 9th 10am UTC+1). The =
voting
will run until September 11th at 10am UTC+1.

The list of all candidates and their platform is available at the =
following
Google doc

=
https://docs.google.com/document/d/1E3_W1c-xJMx9o2PCnKiGt3vqs-mPh77yNO4GSq=
NipOQ/edit?usp=3Dsharing

We will also be hosting an open TAB session at Plumbers on Monday
September 9th at 18:30. A more detailed FAQ about voting procedures is
below.

If you have any questions, feel free to reach out to
tab@lists.linux-foundation.org .

Thanks,
Laura

P.S. Please consider this a reminder to send in your TAB nominations!

[1] =
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/0065=
82.html

---

Q: Why are we making this change?
A: As explained in the previous announcement,
=
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/0065=
82.html
In person voting has a number of limitations. We'd like to move to =
electronic
voting with the objective of giving more members of our community a =
voice in
the membership of the TAB

Q: Who is eligible to vote?
A: All registered attendees of Plumbers and Kernel Maintainers Summit =
are
eligible.

Q: If I am registered for Plumbers but not attending can I still vote?
A: We will be sending the e-mail to all registered attendees before =
confirming
they are present.

Q: Can I register for Plumbers just to vote?
A: Plumbers is sold out this year.

Q: Why bother with electronic voting if the voting pool is still =
conference
attendees?
A: The kernel philosophy is small incremental changes. Based on =
discussions
with the TAB, changing the voting method and widening the voting pool
simultaneously was too much for one year. The goal is to run the =
electronic
voting this year with the same voting pool and then discuss how voting =
will
work in subsequent years.

Q: When does voting start?
A: E-mails with the voting link will be sent out before the start of the
first Plumbers session on Monday September 9th at 10am UTC+1

Q: When does voting end?
A: Voting ends on September 11th at 10am UTC+1

Q: What's the software used for voting?
A: We will be using the hosted version of the Condorcet Internet Voting =
Service
(CIVS) at https://civs.cs.cornell.edu

Q: Is this code open source?
A: Yes. The code is available under a BSD-like research license

Q: How do I vote?
A: You will receive an e-mail by Monday September 9th at 10am UTC+1 with
a link to vote.

Q: Is this method of voting secure?
A: Privacy and security is a focus of CIVS. See
https://civs.cs.cornell.edu/sec_priv.html for more information.

Q: The website mentions ranked choice voting. What is this?
A: In ranked choice voting, you rank your preferred choices from most
to least liked. The theory is this results in a more accurate =
representation
of what the voter pool wants. This is a different method than we've used
for TAB elections in the past where you indicated your preferred $n out
of $m candidates. Because we are using the hosted version of CIVS, we =
did
not have the option to use our old method of voting.

Q: The description mentions an 'election supervisor'. What is this role?
A: The election supervisor's role is to start and stop the poll, send
links to voters, and set various options for the poll. A single e-mail
address is used to e-mail the link to manage the election, after which
anyone with the link can manage the poll.

Q: Who is the election supervisor for the TAB elections?
A: We have created a mailing list for election management. This mailing
list contains individuals from the kernel community who are not running
for the TAB this year, similar to in-person proctors from past years.
We are still working on getting the mailing list set up, the address =
will
be announced when it is ready.

Q: What if I lose the e-mail before I vote?
A: Please e-mail the election list, address to be announced

Q: What if I want to change my vote?
A: This is not possible, please make sure you've made your final choices
when you click submit.

Q: What if I want to practice voting?
A: CIVS has a number of sample polls available. Feel free to vote in =
those
to see how the process works.

Q: What if something unforeseen happens with electronic voting and we =
don't
end up with results?
A: We will arrange an in person vote similar to previous years.

Q: What if I have questions not addressed here?
A: E-mail tab@lists.linuxfoundation.org for the current Technical =
Advisory
Board or the election list, address to be announced

