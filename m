Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3CDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE0F2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfJCKrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:47:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727756AbfJCKrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:47:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75C4DAE8A;
        Thu,  3 Oct 2019 10:47:43 +0000 (UTC)
Date:   Thu, 3 Oct 2019 12:47:41 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Suleiman Souhlal <suleiman@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Kernel Team <Kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Waiman Long <longman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 00/14] The new slab memory controller
Message-ID: <20191003104741.GB6678@blackbody.suse.cz>
References: <20190905214553.1643060-1-guro@fb.com>
 <20191001151202.GA6678@blackbody.suse.cz>
 <20191002020906.GB6436@castle.dhcp.thefacebook.com>
 <CABCjUKBZxJJrUzpgXafqtXOYXZbYXEh0ku8fZLpPHXWnrTw1hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <CABCjUKBZxJJrUzpgXafqtXOYXZbYXEh0ku8fZLpPHXWnrTw1hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2019 at 10:00:07PM +0900, Suleiman Souhlal <suleiman@google.com> wrote:
> kmem.slabinfo has been absolutely invaluable for debugging, in my experience.
> I am however not aware of any automation based on it.
My experience is the same. However, the point is that this has been
exposed since ages, so the safe assumption is that there may be users.

> Maybe it might be worth adding it to cgroup v2 and have a CONFIG
> option to enable it?
I don't think v2 file is necessary given the cost of obtaining the
information. But I concur the idea of making the per-object tracking
switchable at boot time or at least CONFIGurable.

Michal

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl2V0cgACgkQia1+riC5
qSiS8Q/+PD9xLl7wTtZ2Szhh4I3R+ekhSzu8UljRTQaRhGkZ02x+WghUg+lQw4BF
lNojzw0iZ23XvbU4ag9wjzTP/95dLi6Yx16XaKA4OflVodG8+t/LVVJM8Wg7Pb1R
bXo6PBIMShBJyW6BhMQww9w+URa32Xlj1QDAghV+98NhOFj+kZeEDHcHmYlpIIVT
JACiBiohAAUrkbzubKek30TYV1e6Bo8Z8woUEMrLeVTvzvkg6N/sdiO15B8UJ91b
6vIt4DFW/YqE3gT6bFUa9gyqaOwsoDYsqHKfoyRQ9NxGvu7gkE3yjg+D9bxeNt5j
GJK7n/qsVuy0r63BihF6FcAcVhlT7ooZ/eUd2ee7y0dguLq9u8KlMjL7Viq0BDeM
Ok33fjF0FSWXKiT1VCIJDOuhyU72DLF9/rPkEWjmMIq093IdOF88nlVcqE0SQRbU
HQkHK/7rg1LeLB6E+TPwNdZRUU7d0ZcGRXzhKq6X8Lbz0waDXmKwcS4Dk8025cfF
2XCFJTxdLqla8RUQDpKdO2Og74J8r+iDZMV5XNE5nKFo7GkjEYcQTqZK2ObsTvjt
0pd+lAXQ5izEXIn0dk4/4bs7n/E9OrFO4U0gp/XchniVgO1G5i8UAcQ+vxIx6Ji6
0f8OISou7eCBJNG+BxxIYEo6HoHO0pik5BRFoa2Yu0F1oWz/LyE=
=eCqp
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
