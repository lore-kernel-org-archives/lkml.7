Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79026C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 03:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEDD206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 03:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="qhcnxHpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfEEDuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 23:50:06 -0400
Received: from mx1.cock.li ([185.10.68.5]:55519 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfEEDuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 23:50:06 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 May 2019 23:50:04 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1557027723; bh=NUDdW5ZrpiAbLTxZs8JXE+qZXB0Y7p5sqNSW9bmT6a8=;
        h=Date:From:To:Cc:Subject:From;
        b=qhcnxHpVMyvJhXZFT+YTrB8sy6YDeBCGYH5MsJeUcA3eKlUr/+WRyJaKhhlmLoZ4E
         fs4Zws7L0Oq1rNzqibS+aW73wGumCVudJfDWLUP3RjS0Q7Neac96sWFrK1Ld31EWAy
         rnrLolXOImdwHx1QBw1VYGtZ2k6j00ZWaomxgfvoGI4wX5cTdX09Dvr3i+epCnigBd
         irWOUsCvmwEWbEwdIHhzhz2h9rmdL0bqbWDWxqczm5+GrGCr94oHv/O1D320jq7xkG
         HViiJUzWgSA0cIp6FlrhQbhfJ1WRX57BEhwBwUj47/RsMgrBiUILG6Zkac/zWzt+uu
         DU5k2UYgUYB+g==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 05 May 2019 03:42:02 +0000
From:   vsnsdualce@redchan.it
To:     bignose@debian.org
Cc:     debian-user@lists.debian.org, linux-kernel@vger.kernel.org,
        qmastery16@gmail.com, rhkramer@gmail.com,
        mailinglists@mattcrews.com, jhasler@newsguy.com, scdbackup@gmx.net,
        richard@walnut.gen.nz, curty@free.fr, jmtd@debian.org,
        mick.crane@gmail.com, tomas@tuxteam.de, steve@einval.com,
        joe@jretrading.com, rms@gnu.org, esr@thyrsus.com
Subject: Re: Can a recipients rights under GNU GPL be revoked? - Yes if they
 are free(gratis) licensees.
Message-ID: <a8a3648020865b3e819213fccce645d9@redchan.it>
X-Sender: vsnsdualce@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, if the licensee has not paid anything (no money, no service, etc) 
that you asked him for, for the license, it can be freely revoked. The 
"clarification" by the FSF is complete and utter bullshit (and was 
prompted by my writing on the issue).

For a licensee to prevent a revocation, he must be able to enforce some 
promise regarding revocation (when it can occur, etc) that the copyright 
holder made to him.

In order to have an enforceable promise he must have paid the owner 
something for that promise, otherwise it is an illusory promise and will 
not be enforced by the court.

"Promising" to fulfill a pre-existing duty is not sufficient payment 
(consideration) either. One pre-existing duty we all have is to follow 
laws. Promising to not violate someone's copyright is not valid 
consideration as it is a pre-existing duty.

Before the license grant the free-taker has the following "rights" to 
the work:
Nothing.

After the license grant he has the following permissions regarding the 
work:
(Whatever the license says).

And for that he has paid the copyright owner: nothing.

No valid consideration, no contract, any "promise" made in the license 
text is illusory: it cannot be relied upon (including the "irrevocable" 
clause in the GPLv3: that clause is _inoperative_ from the perspective 
of a free-licensee vs the owner).

(Additionally, consideration, to be valid, must be bargained for. 
Tendering unwanted "consideration" is no consideration at all, thus the 
"fame is payment enough" argument from the dicta of a 9th circuit case 
is of no value when the licensor did not specifically bargain for such 
in exchange. You cannot hand the owner something after the fact and 
declare it valid consideration)

You can revoke. You can do so for any reason or for no reason at all .



The FSF and SFLC swear that you can bite the hand that feeds you for 
free. They are incorrect and purposefully deceiving you in order to 
safeguard their movement against the men who actually did the work to 
create the corpus it rests upon.



Note: If you would like a nice expansive legal paper to read on this 
issue, Sapna Kumar's paper is good: 
https://scholarship.law.duke.edu/faculty_scholarship/1857/
If that is too formal and you prefer a stream of consciousness message 
board fight on this issue, the LKML has you covered: 
https://lkml.org/lkml/2019/5/3/698  (and it covers the 9th circuit 
Artifex case and 9th circuit Artistic License case which some people 
will try to make you think invalidates your proprietary rights)
If you want a book, to have and to hold, that recognizes this: 
https://www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
If a paper by some mere lawyers isn't good enough, a law professor's 
take on the subject might be more you style: 
https://papers.ssrn.com/sol3/papers.cfm?abstract_id=243237

Yes, the GPL is revocable from free licensees. Yes they will fight you 
in court if you revoke from someone who cares, so when you are thinking 
of revocation: 1) properly register your copyrights ... 3) Then revoke 
from an entity domiciled in a property-friendly circuit that isn't going 
to simply invalidate the idea of contracts requiring actual valid 
consideration (IE: do not revoke from someone in the 9th circuit as your 
first course of action: revoke from an entity in another circuit)

(Also note: Do not send a cease-and-desist letter off the bat: the 
entity can then rush to the court house to seek a hearing regarding his 
rights to the work. You don't want to be in a race-to-the-courthouse 
situation and not even know it)

Part 0) and 2) are :Get [an] experienced copyright attorney(s) who is 
well familiar with the leanings of the various federal circuits so you 
can formulate a proper strategy. The 9th circuit loves "Big Tech" and 
doesn't much care for the formalities of law, and if requiring 
consideration to actually exist regarding copyright licenses for them to 
be mutually enforceable contracts gets in the way of California's Tech 
industry: guess how they're going to rule in a "new insightful 
groundbreaking finding".


On 2019-01-27 13:23, rhkramer@gmail.com wrote:
> On Sunday, January 27, 2019 06:47:05 AM Ben Finney wrote:
>> Howdy all,
>> 
>> Recently in this forum, some concerns have been raised about works
>> covered by GNU GPL. In particular, whether a recipient of a work,
>> received under conditions of the GNU GPL, can have the freedoms of the
>> GNU GPL later withdrawn in that same work.
>> 
>> To reassure those who might worry whether they can reply on the 
>> freedom
>> granted in a work, it is worth reading the GNU FAQ document for the 
>> GNU
>> GPL at the Free Software Foundation:
>> 
>>     [For any GNU GPL-licensed work,] the public already has the right 
>> to
>>     use the program under the GPL, and this right cannot be withdrawn.
>> 
>> 
>> <URL:https://www.gnu.org/licenses/gpl-faq.en.html#CanDeveloperThirdParty>
>> 
>> The same answer is in the FAQ specifically for the GNU GPL version 2.0
>> <URL:https://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.html#CanDevelope
>> rThirdParty>.
>> 
>> You can read more in the Software Freedom Conservancy's document
>> _Copyleft and the GNU General Public License: A Comprehensive Tutorial
>> and Guide_, specifically in §7.4 \u201cGPLv2 Irrevocability\u201d. 
>> That concludes:
>> 
>>     Whether as a matter of a straightforward contractual obligation, 
>> or
>>     as a matter of promissory estoppel, a contributor\u2019s attempt 
>> to
>>     revoke a copyright license grant and then enforce their copyright
>>     against a user is highly unlikely to succeed.
>> 
>> 
>> <URL:https://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007
>> .4>
>> 
>> In other words: Any copyright holder can *say* they wish to
>> retroactively revoke the GNU GPL to some party. However, unless that
>> party has violated the conditions of the GNU GPL grant they originally
>> received, there does not appear to be any enforcible threat of
>> revocation that would succeed.
>> 
>> I hope these, along with the many court cases world-wide that have
>> tested the GNU GPL and found it to be enforcible, can reassure those
>> considering whether a particular copyright holder's whim can revoke 
>> the
>> freedoms guaranteed in a GNU GPL-covered work. I'd say there's nothing
>> to worry about from those threats.
> 
> I don't disagree with what is stated here (but I have a headache and 
> didn't
> read it carefully), but, even without reading carefully, I believe that 
> the
> original author of a package could do something like create further
> modifications to the code and create a non-free version of the code.
> 
> Assuming that is correct, people using (or basing modifications) on the
> (presumably) older free version could continue to use and develop based 
> on
> that, but would not have rights to that new non-free version.


