Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BE12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfCRAPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:15:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfCRAPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CBFE6ACFB;
        Mon, 18 Mar 2019 00:15:10 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 18 Mar 2019 11:15:02 +1100
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Network Development <netdev@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rhashtable: rename rht_for_each*continue as *from.
In-Reply-To: <CANiq72ncNHCrE+YRePDCPGgKoKYCSL0mwJXP0jBjYP6W4CVSKA@mail.gmail.com>
References: <155253979234.5022.1840929790507376038.stgit@noble.brown> <155253992833.5022.6459847129731180970.stgit@noble.brown> <CANiq72ncNHCrE+YRePDCPGgKoKYCSL0mwJXP0jBjYP6W4CVSKA@mail.gmail.com>
Message-ID: <87mult82d5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sun, Mar 17 2019, Miguel Ojeda wrote:

> On Thu, Mar 14, 2019 at 6:10 AM NeilBrown <neilb@suse.com> wrote:
>>
>> The pattern set by list.h is that for_each..continue()
>> iterators start at the next entry after the given one,
>> while for_each..from() iterators start at the given
>> entry.
>>
>> The rht_for_each*continue() iterators are documented as though the
>> start at the 'next' entry, but actually start at the given entry,
>> and they are used expecting that behaviour.
>> So fix the documentation and change the names to *from for consistency
>> with list.h
>
> Thank you for taking care of the .clang-format changes!

:-) that's what "git grep" is for!

>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Thanks,
NeilBrown

>
> Cheers,
> Miguel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyO4wYACgkQOeye3VZi
gbna7w/8CVyrkuv82s4gF4DictBH4yMYEU5QogIvIwUi5Nk9UKLMHPI8ABfzbiWW
rzvTQigIIf1O4E5J1vb0LgDwuFQ8PqLseCPFdZlUWJvY4uEmcfsJJNFKVxFD4a2b
cX7TXfLFGr6mnozc+mxrd1o/V2z+YTTmt1+Xy/1BQsh0imrB3neUIix9ed5SuxcM
Wt9LmJAXzcUo+A8T+OaDEgp7racON2M9puvxYwqnw//rbMSu4x85u4Y/r+xd+rur
jMuWCwYGtL6xxmKLkh5iGnSw8vflCFKXg8P9qb5SBhlhdH69PdBQiGu7n9fQryZP
TmJAe+Q7bzUz4YtZdb9NJpG56SPa0DOZT4zgirCC2uIpZi+F1nFtd7KnBmh8cD/U
pds0hhetXmAORuheITATAsNV2z9WsMPTOF80mmNIVlMeuIECipOO9+LLqaWD31+Z
HH6nvR6hMhn0tKyJ3yCEDlgHAvEGmgTkkk8AIw97WeF3WNbLRSUzy4nQbdVBHH8t
rVkruNUKn0KOSQ3NcdSkrb9hRmDjvRvOegfcpX0sLDN9277q9F/jjeMRvXrjAGZ3
aF3Ww0HucZQJgo0wss2XbqbFq+6dFJ2JC7NnX6zCYU485Zwpt+sC9BZMRsDwujse
yzPDYGdp37M/2lCnaKeNQyBy9cF62jFepuzjq4hMXlIDP4bGy7s=
=HODk
-----END PGP SIGNATURE-----
--=-=-=--
