Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B88BC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7824B2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="nM7iyKG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfECTbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:31:21 -0400
Received: from mx1.cock.li ([185.10.68.5]:60985 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfECTbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:31:20 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1556911873; bh=rSQd9nNa7ET/FbzkVHsdAjUKkYax2fxau0e19we0eew=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=nM7iyKG0Gf1if0tSR5EbmugOJ2wDSnPGZ5O+b9j11Xq3A+0D/NimADW4N3rOv5/lF
         NIf9XAW7GRmXxRMRchwgg1/XLY/NNUxToBATZV6hlY+dE0E9Ym9WSqCCsoRWTD3cQC
         iiy7scjPFr9mbaVJxLZmp42jcFTDxWSuzpg0xflSBwSO7ZwS62YUKFBWXPkF2nktD+
         Bjc4fs6S+P9vJP6hlpiAZ7TNTyd+5GTNM5I2H+uls2OeztIouPsIfqGhPBkqRcsPI/
         G+A9x6RY5YeZNRRMvBKmvQNFjvX/nqVC4LZZXpo3NXOfu4w9RKLunfEjZVip+vp0ef
         LYDrOPaDQKj3Q==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 May 2019 19:31:13 +0000
From:   mikeeusa@redchan.it
To:     linux-kernel@vger.kernel.org, editor@lulz.com, misc@openbsd.org,
        esr@thyrsus.com, rms@gnu.org
Subject: Free Licenses are revocable by the Copyright holder.
In-Reply-To: <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5851873@github.com>
References: <5c51daed7c023_2fcf3fe7576d45c417207b@github-lowworker-89d05ac.cp1-iad.github.net.mail>
 <5c51ee838b18f_74e53fd6ff0d45c41780e2@github-lowworker-5909e27.cp1-iad.github.net.mail>
 <5c522f5b6cb8a_60733fc5256d45b412831@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c534f0336ca6_19ae3fcbf5cd45b4186161@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <5c535110f0f30_3aa13fafe46d45c4222962@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <061a28afa26cf5ad7d11f8074353a9cf@redchan.it>
 <5c5489478eb20_56f33fd9e9ad45b43146ec@github-lowworker-4f62d42.cp1-iad.github.net.mail>
 <5c55ecdcb298_3a283fd6dfcd45c4309246@github-lowworker-63e61ec.cp1-iad.github.net.mail>
 <5c563190ae6cc_18c33fcb464d45bc1523b0@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c586b095281b_4c6d3ffba28d45b8120450@github-lowworker-e51511d.cp1-iad.github.net.mail>
 <5c58a56f8ded7_36e93f9cb4ad45b8932e7@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <312c3d91f6c4a71c34b96728a2efb385@redchan.it>
 <5c5b1609a1561_1ac23fbe2d6d45b88762d0@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5812163@github.com>
 <d6326acd7a9a52a5cf4de2bd3841fc5c@redchan.it>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5851873@github.com>
Message-ID: <1cf210543f9d3848c9a1ba263037746a@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A defense against license revocation is the existence of a contractual 
relationship between the copyright-owner and the licensee.

However, where no such relationship exists, no such protection is 
apparent.

Obeying a preexisting legal duty (such as to not commit copyright 
infringement by using/modifying/etc a work without permission) is 
insufficient to create a contract.

Illusory promises are not binding upon the grantor.

For those who have chosen to not pay the Grantor of a "G" "P" "L" (GPL) 
license, the license can be revocated at the will of the copyright 
owner.

""retroactively""

Remeber: non-exclusive licenses do not transfer any rights. Only 
permissions (license), which can be revoked, and without a contractual 
agreement such revocations do not give rise to damages against the 
Copyright owner.

Nothing gets you nothing.

> WE'RE GOING TO DISBAR YOU, YOU'RE NOT GOING TO BE LICENSED FOR LONG.

Go fuck yourself, enemy.

http://boards.4channel.org/g/thread/70789199






---



> Artifex!
In Artifex v. Hancom the court doesn't even correctly identify the GPL. 
It misconstrues the preliminary ("pay us for commercial license or use 
the GPL") writing (offer to do business) + the GPL as "The GPL".

Additionally in Artifex the situation is where the licensee decided NOT 
to pay and NOT to obey the GPL gratis license either, thus Violating the 
Contract the court construed created by the licensee "accepting" the 
preliminary writing / offer to do buisness ("Pay us OR GPL") (licensee 
chose : NEITHER! But I still USE! HAHA!").

The remedy is EITHER a breach of contract remedy (for not paying under 
the preliminary license) OR (and NOT BOTH) Copyright Damages for 
violating the license.

Copyright holder was given the option to decide.

This have little relevance to where a Copyright Owner allows gratis 
(free) licensees and then chose to withdraw/cancel/rescind the gratis 
licenses.

Regardless of what smoke FSF / SFLC and corp wish to blow up your ass.







---



> Not true, you enter an implicit contract the moment you start using a 
> product with a free license. Note that I've said product, not service. 
> Services can very much update their terms and conditions, and 
> frequently do so. Equally the creator can change the conditions and 
> licensing on updates or new versions of a product. You can't be revoked 
> a free license for a product you're already using though.

Incorrect, where the user has paid no fee (or service or action) to the 
copyright holder, there is nothing to support the existance of a 
contract where the user could hold the copyrightholder to the "terms". 
(IE: the free-taker attacking the hand that fed him)

The user MUST obey the license, but that is due to copyright law, not 
contracting law.

A court, may, at it's discretion, choose not to enforce the Copyright 
Holder's lawful rights under equity, of course, and may indeed do so for 
a lay user (a consumer). The use allowance would likely only extend to 
actual use of the software: not modification and public distribution.

(So-far, one must note, the courts only did so for commercial software 
for paying customers, some 1990s cases)

The Copyright Holder can prevent the use of its code in new versions of 
the product, aswell as new distribution of "old" versions of it's code 
(IE: pressing new CDs containing the now-withdrawn code (or 
new-downloads of said withdrawn code)). Shops that have old linux 
distributions with stock of old linux CDs would likely be-able to still 
sell that stock, however modification and distribution of the withdrawn 
code would not be allowed by the user of such.

The Copyright owner has not transfered his interest in controlling the 
distribution and modification, etc of his work. He has simply allowed it 
to occur, free of charge. That can end at any time.

The FSF requires a transfer of copyright for this very reason, 
regardless of what other surface excuses they give as excuses (which 
almost seem like fraud-in-the-inducement, honestly)




---


>> 70752638
>    Did you go to a legitimate law school or did you study law all by 
> yourself?
Legitimate law school. My professors from the school agree that free 
licenses do not create a contract, and the license is revocable: They 
take it as a matter of course: it's obvious on it's face.


>> 70752641
> That's not how licensing works, you fucking idiot.
Yes it is. You are thinking of commercial copyright license contracts, 
which is what your handbooks inform you on. The entirety of the 
"irrevocability" argument you find therein is the existance of a 
contract between the grantor and the licensee, which binds both to the 
terms. With free licenses no such contract exists, due to a lack of 
consideration on the part of the licensee; and no: "I promise to not 
violate your copyright" is not valid consideration as it is a 
pre-existing legal duty.

Other lawyers who have expressed similar opinions are David McGowan and 
Lawrence Rosen, in addition to Kumar (author to a rather famous paper on 
the subject).

Lawyers who have concretely stated otherwise are:
No one. The best you get is a highly couched statement of dissimulation 
from one Red Hat attorney who was hired by the Software Freedom 
Conservancy.

More recently the Male Red Hat attorneys put out a statement that 
tacitly acknowleges revocation as a danger from "judgement proof" 
individuals (IE: pennyless, unemployed, NEETs, who can't be fired from 
the job they don't have in retaliation, and hold no recoverables (thus 
the threat of protacted litigation and legal fees during holds no sway 
over them)), individuals who happen to make up a sizeable portion of 
Open Source copyright holders.

>> 70753928
> Oh man, I'd fuck Yotsugi.

>> 70753918
> cute doll

Correct

>> 70753935
> why make this thread every day?
Because you do not like this thread yet.






---



>> 70762568
>    This is why you either do not accept contributions at all or use a 
> CLA.
Exactly.

Which the FSF has _ALWAYS_ required.
It is linus that changed this tone, and linux did profit from it with 
much more programmers than it otherwise would have had.

Any statement by the FSF etc to the contrary is simply trying to give 
free cover to linux etc for a problem the FSF didn't actually create. 
Very generous of them, but not legally accurate.







---








>> 70766437
> Promissory estoppel.

Promissory estopple is an equitable defense, used when a heir is 
promised land, then improves the land outlay of monies, and then the 
estate denies him title. In this area it's related to the ancient livery 
of seizin, and without reference to that would not have been accepted by 
the courts in the first place.

Another area it's used is when a worker would otherwise be dispossessed 
of his rightful renumeration because of some failure in contract 
formation, the courts sometimes use promissory estopple to get the 
promissor to not stiff the contract worker. Here it's similar to quantum 
meruit in a way, or quazi contact theories.

A third time it's used is when a father promises a daughter something, 
the courts felt bad for the daughter (a woman, duh) and estopped the 
father from not giving her money.

In the first and third case it involves a family member and a one to one 
promise from the estate holder. In the second case it involves a worker 
who did the work and was about to get screwed.

In no cases has it involved non-exclusive "promises" to random 
unidentified strangers involving software licenses.






---







>> 70765621
     I would never earn a dime from it. The best case scenario is that 2 
trillion dollars worth of value vanishes from the economy with the 
revocation of the linux kernel permissions by the copyright holders.

     Which they CAN do if they chose to.





---







     I want everyone to understand that "promissory estopple" is the LAST 
port of call for a dying contract, and it is NOT a defense at law: it is 
a defense in equity.

     Every time a delinquent apartment dweller gets thrown out of their 
apartment they claim "promissory estopple". The court might give them a 
few more months to pack their things.

     When the other side rests their case on promissory estopple that 
means they have no case at law: they are simply going to beg the court 
"THIS IS NOT FAIR, PLEASE DO NOT ENFORCE THE LAWFUL RIGHTS OF THE 
PLAINTIFF AGAINST ME". It is at the courts discretion to enforce your 
rights or not, and since self-help is not allowed anymore in most cases, 
if the court won't help you you're not getting any help.

     What the other side is saying here is that the court should just 
simply give you the apartment. That it is "fair" that they get to 
convert your property to their property, for nothing, because.

     Since the other side is a bunch of "_women_" and 
"_supporters_of_women_" perhaps they have a super strong case that they 
should effectively own YOUR copyrights, MMMAALLLEESSS.







---






>> 70766513
> Also, the consideration here would be the right to work on the project, 
> which is good and valuable because of the reputation, experience, etc. 
> which comes from contributing code.

Linus needed permission from nobody to contribute code to himself.

Consideration, to be valid, must be bargained-for consideration. 
Non-bargained for consideration is no consideration at all. Those 
copyright holders who licensed their patches under the GPL, did not 
necessarily seek fame, reputation, etc, and such was not promised by the 
linux project to those programmers in exchange for the licensing of the 
code. There was no exchange of bargained-for consideration.

> Thanks for playing, anon.
Sorry snaky fuck, I've researched this far more than you, am an 
attorney, and can cite 3 other attorneys who have published papers and 
books recognizing that the GPL is revocable.








---







>> 70791852
By law the rights one has to anothers work, by default, are: nothing. 
You cannot modify the work, you cannot distribute the work, you cannot 
make derivative works of the work, you cannot copy the work.

You have a pre-existing legal duty to obey copyright law.

The owner of the work then grants you permission to: modify the work, 
distribute the work, create derivatives based on the work, distribute 
derivative works based on the work.

He is not agreeing to any contract with you. He is stating how he will 
allow you to use his property.

You "agreeing" to abide by his instructions regarding his property is 
not "consideration" as it is a pre-existing legal duty if you want to 
use/modify/distribute the work at all.

See the images: >>70791847 >>70791638
Or read: >>70791578




---





>> 70792249
Wrongo. Without paying consideration, the free licensee cannot hold the 
licensor to any promise not to revoke.




---



>> 70792239
> suiseiseki is best doll
She's kinda mean to the MC, I like her alot ofcourse, but I think her 
sister abit more.

> ...do people no realize this? If you didn't sign a legally-binding 
> contract, you probably aren't under a legally-binding contract?

They will simply ignore you. They want something for nothing. Basically 
they want to commit the tort of conversion against the copyright owner 
and have the courts agree to that.


See: Pre-existing duty rule, and Illusory Promise

The licensee only has license to use the work so-long as the licensor 
does not revoke that permission. Since the licensee has not secured his 
interest, he has no defense at law to revocation.






---



>> 70792280
> "quote"
> Let's libel David McGowan, Lawrence Rosen, and Sapnar Kumar now!

>> https://scholarship.law.duke.edu/faculty_scholarship/1857/
>> https://www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
>> https://papers.ssrn.com/sol3/papers.cfm?abstract_id=243237

Those three attorneys are correct on the GPL. No one has ever been able 
to come up with a paper refuting them. (And no the couched words at the 
FSF do not count: logically those "updates" don't actually say anything, 
but a non-lawyer wouldn't understand). Eben Moglen, over half a year ago 
claimed he would write a paper showing the GPL irrevocable (see lkml 
mailing list)... we're still waiting.








---




>> 70793195
Yes, I am a US attorney, I am talking about US law.

>> 70793199
Oh the 9th circuit non-binding dicta where they wax poetically in the 
middle of the decision for a page an a half about how they love linux, 
and then rule exactly the opposite in the actual opinion. Yea I've read 
that case.. and the thing is... I'm an attorney so I know what 
non-binding dicta is. And you don't, because you're not.

Still doesn't matter: that "consideration" wasn't bargained for. You 
giving something that that someone doesn't want and didn't ask for 
doesn't suffice as consideration.






---





>> 70793247
> Why is THAT possible and not
Because you did not pay.
It's that simple.

If you did pay for a license, and there are specific conditions 
regarding revocation, the courts in the 90s decided that if you were a 
consumer, it would hold the commercial entity that sold you that license 
to those terms equally, because your purchase of the license was 
consideration.

When you get a license for free, there is no consideration.

"But I PROMISED to only modify/distribute/etc the work in accordance to 
the permission granted to me by the copyright holder, isn't that a 
Promise for a Promise".

No: That's a pre-existing duty. You have no right, outside of the owners 
consent, to modify, distribute, create derivative works. You do have a 
DUTY to obey US Copyright Law, and not violate his copyright. Only his 
permission allows you to do these things regarding his work: so you 
assenting to his "gift" of permission is not a detriment against you. No 
consideration there.

> some entrapment of sorts?
Applies only to police vs criminal situations (criminal law), not civil 
law.






---





>> 70793313
The lay idiots here
1) Think the 9th circuits' opinion is binding on the whole of the USA
2) Think the 9th circuit ruled on the issue (it did not: that is 
non-binding dicta, it's not even binding on the lower courts)
3) Don't notice that the 9th circuit court of appeals, a few pages 
later, ruled in the opposite direction of it's dicta and found NO 
contract: only bare copyright license, and sent the case back down to 
the lower court.

Additionally, even if there were all those "nice" things the Copyright 
Owner was allegedly receiving (things made of thin air, which are 
worthless: the 9th circuit is said to be "a bunch of woman worshiping 
faggots", as we all know, (like all white men (regardless of 
religion))), if the Copyright Owner didn't seek such things, didn't 
bargain for them, there is STILL no valid consideration.

You can't just hand me something I don't want and didn't ask you for and 
claim you satisfied contract formation.

Yet that is what all the white boys here are claiming.







---




>> 70793438
>> 70793336
> > When you get a license for free, there is no consideration.

> So if you provide a free cubic meter of concrete during house 
> construction in the USA, you can later turn around and reclaim that 
> free cubic meter of concrete even if the house collapses?

That would be a gift, not a license. A license is permission. A gift is 
a transfer.

> If someone presents you money, they can reclaim it the day after you 
> spent it because it was "no consideration"? Lel.

Depends on the terms of the loan. You do know creditor law, correct?

> > Applies only to police vs criminal situations (criminal law), not civil law.
> Seriously?
You can beg the court not to enforce someone legal right immediatly, 
this is done all the time in apartment disputes, the court might give 
you a few more months to move out when you cry under Equity (not law) 
"HE PROMISED! IT'S NOT FAIR". Depends on if you're a white woman or not. 
Blacks get treated like shit regardless of gender, men get treated like 
shit regardless of race.

> Your civil law has no analogous protections (even if they're not called 
> entrapment legally)?

It's called a contract, but to have one you need to give the other 
person something that they bargained with you for. Nothing gets you 
nothing; it's very fair.


>> 70793474
Opensource licenses are never litigated unless there is a corollary 
agreement that can provide for monies.
IE: "Hey, you can pay us for a commercial license, or use the GPL" etc. 
People who give things away for free don't have money for lawyers, 
additionally if they didn't register their copyright before the 
violation, even if a same-similar violation occurs after registration 
from the same party, they can still only get damages (no statutory 
damages, not attorneys fees).

The damages for a thing costing nothing is nothing, usually.





---






>> 70793484
> A Court's decision influences other Courts. If another Federal Court 
> brings up a similar case they will look to this case and probably rule 
> similarly.

Do you know what non binding dicta is?
Nothing was ruled upon regarding the GPL's revocability in that case.


> My main reason for bringing that case up is that the Court upheld the 
> license's conditions as valid. That should work both ways if the 
> conditions were valid that means any line that says >>70791519 is also 
> valid.

No. The court held that the license was not a contract, that it was only 
a copyright license. Meaning that the licensee was duty-bound to obey 
the license, and if he chose to impinge upon the Owner's federal 
copyright rights outside of the license, he was committing copyright 
infringement and damages as such were obtainable.

The court ruled that the license was _not_ a contract (the violator 
wanted it ruled a contract so he could get away with just whatever the 
contract damages would be, which would be much less than statutory 
damages + attorney's fees, or profit damages) and sent the case back 
down to the lower court to dispose of it properly.

Did you even read the case?



---






>> 70793784
Looks like you missed this: >>70789214
shit for brains.

The printer driver company sued some violator, the court said the 
violator either had to pay the printer driver company the asked-for 
commercial license fee, or suffer damages under federal copyright law, 
and it was the printer driver's decision which way it wanted to go: 
pretend the violator simply had a commercial license contract and failed 
to pay, or find them to be violating the copyright because they didn't 
abide by the GPL. IE: commercial license contract OR no commercial 
license contract, copyright infringement instead.

This was not a case of a copyright holder rescinding a license from a 
free-taker who wasn't asked for nor did tender any consideration.

Also the court didn't even correctly identify "The GPL" and took "The 
GPL" to be the commercial copyright license offer + the (actual) gpl.

Sorry kid, try again. The FSF (and bruce perens) is blowing smoke up 
your ass once again.

> Google requires 20 more captchas... really doesn't like this thead. 
> FUCK YOU GOOGLE WOMAN WORSHIPING FAGGOTS: THE GPL ____IS_____ REVOCABLE 
> FROM FREE TAKERS




---


>> 70793810
     Nope. If the licensee wishes to distribute the work at all, he must 
do so only with the copyright owners permission.

     The copyright owner is not allowing distribution sans-license text.

     The licensee has no pre-existing right to distribute the work, nor 
derivatives of the work.






>> 70793828
     The owner can revoke permission to distribute, make derivatives, 
make copys, of his work at his will, unless the licensee has secure 
rights otherwise.

     The licensee secures said rights by entering into a valid copyright 
license contract, supported by valid consideration.

     Of which there is none for the free-taker.

     "I will not distribute your property in a way I am not permitted to" 
is not valid consideration.

     >20 bicycles later











>> 70793941
It does not matter what the license promises, at all.

You did not pay valid valuable bargained for consideration to the 
licensee: you cannot rely on those statements.

It is an Illusory Promise.
You "agreeing" to those "terms" is not valid consideration because such 
is subject to the Pre-Existing Duty Rule. You have no right to do 
anything regarding the property without the owner's permission, agreeing 
to abide by the owner's rules regarding his property is simply a duty 
you must follow if you do not wish to violate the Copyright statute. You 
have a pre-existing duty to obey applicable laws.

> Myriads of storefronts and crosswalks later







---






>> 70793958
> A license is what it says it is.
Yes, permission. Permission that can be revoked by the owner of the 
thing being licensed, unless there exists some secured interest against 
him doing so.

> You are licensed to use that work by the author provide that you agree 
> to abide by the conditions.
As long as he wishes for you to do so. If he chooses to end that 
permission he can do so at any time, unless you have a valid secured 
interest against him doing so: by having a valid contract backed by 
bargained for valid consideration.

> The author cannot revoke your access for no reason if there's literally 
> a section that that says it's irrevocable.
Yes they can. Without a contract that is an illusary promise. 
Non-binding on the grantor.

If you want it to be binding: pay him something he's asking for, and not 
something you already have a duty to do or preclude yourself from doing 
absent permission.


Or let >>70791638 Yotsugi and >>70791847 Yotsuba explain it to you.

Or how about Sapna Kumar:
https://scholarship.law.duke.edu/faculty_scholarship/1857/







---


>> 70794023
They won't listen because they are lay idiots, or opposing counsel.

>> 70794036
1: that is non-binding dicta, in a case involving the artistic license.

2: the court ruled against what you think the dicta suggests, ruling 
that the artistic license was not a contract, and was instead a BARE 
copyright license.

3: If you did not ask for "fame bla bla bla" and X gives you "fame bla 
bla bla", that "consideration" he tendered you is NOT VALID because YOU 
DID NO REQUEST IT.

Sapna Kumar's paper touches upon this, seems you didn't bother to read 
it.

Now, last time I checked, GPLv2, even GPLv3, did not ask for "fame and 
recognition" in exchange for "freeloaders doing whatever they want with 
my copyrighted work, forever and ever amen".

There is no consideration. Bullshit consideration is not allowed by many 
courts either ("Hey, I gave him a pen! For this 100,000,000 dollar 
mansion" 'Oh looks like a estate tax dodge' --Court), so the 9th circuit 
can wax poetically all it wants, it doesn't make it so in the rest of 
the country (even though YOU THINK IT DOES), and doesn't make it so even 
in their circuit (because they did not rule on it).






---





>> 70794077
> How does that the requirement to distribute the license text with the 
> work is a Pre-Existing Duty?

You have no pre-existing right to distribute the work, you only have 
permission, by the copyright holder, to distribute it in the way he has 
instructed. If you do not do it in the way he has instructed, but do so 
in some other way, it is simply a violation of his right of distribution 
under the Copyright statute.

You must obey the Copyright statute.

You promising to obey the law is not valid consideration.

"You may distribute my work in this way"
Is purely a gratuity to you.
It is more than "You may not distribute my work at all"





---







---


>> 70775710
> ITT: Redditors with Reddit spacing pretend they are lawyers who know 
> anything about copyright law.
https://scholarship.law.duke.edu/faculty_scholarship/1857/
https://www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
https://papers.ssrn.com/sol3/papers.cfm?abstract_id=243237

Read up.



---

>>> 70794074
> So this is what he meant when he said libre.
     Yes. Free works both ways: you are free from payment, and also free 
from rights.






