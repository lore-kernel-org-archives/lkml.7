Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1DBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47392064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574806807;
	bh=uEp91eMvhLvtp5WwBQenJ4J9r4BER868/pkRXTx1UAc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TdcK+09lyD1IAy739XfwgAgZMieuSvga9Qu8Ha1E3MG/F85dSh2+aZl70PU0AzzuG
	 zHQPLSq+dEbJ+b6LQb+EQOCSJrOa4YbcKg+AkgwYrMZBHtn/M98k/ZrAHkbqZQSKLT
	 aWK7bWKjRR3M2sxWapBwgAJok9SgiJGMCmatqrls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZWUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfKZWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:20:05 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6372C2064B;
        Tue, 26 Nov 2019 22:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574806804;
        bh=uEp91eMvhLvtp5WwBQenJ4J9r4BER868/pkRXTx1UAc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V8qSdiQVq8WyroBnFV78iPiakIPxxL3L8flDxDsLrlO0YR/WgHZcf4DTlixbDeszC
         IWUf1RN9FYklZw7Ur5r9pEsC1fNjwrFDzAf8c6krHXq8zvAlHchXpwwa/cLBwr6GUp
         FsZyYXD5zNXrHmUSKAL4BH3JyoryxAYWna33jMr0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1424C35227AB; Tue, 26 Nov 2019 14:20:04 -0800 (PST)
Date:   Tue, 26 Nov 2019 14:20:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/barriers/kokr: Remove references to
 [smp_]read_barrier_depends()
Message-ID: <20191126222004.GV2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191108170120.22331-10-will@kernel.org>
 <20191121193209.15687-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121193209.15687-1-sj38.park@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 08:32:09PM +0100, SeongJae Park wrote:
> This commit translates commit 8088616d4ca6 ("Documentation/barriers:
> Remove references to [smp_]read_barrier_depends()") of Will's tree[1]
> into Korean.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/Documentation/memory-barriers.txt?h=lto&id=8088616d4ca61cd6b770225f30fec66c6f6767fb
> 
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>

Queued, thank you, SeongJae!

							Thanx, Paul

> ---
>  .../translations/ko_KR/memory-barriers.txt    | 146 +-----------------
>  1 file changed, 3 insertions(+), 143 deletions(-)
> 
> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> index 2774624ee843..42509b86542f 100644
> --- a/Documentation/translations/ko_KR/memory-barriers.txt
> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> @@ -577,7 +577,7 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
>  데이터 의존성 배리어 (역사적)
>  -----------------------------
>  
> -리눅스 커널 v4.15 기준으로, smp_read_barrier_depends() 가 READ_ONCE() 에
> +리눅스 커널 v4.15 기준으로, smp_mb() 가 DEC Alpha 용 READ_ONCE() 코드에
>  추가되었는데, 이는 이 섹션에 주의를 기울여야 하는 사람들은 DEC Alpha 아키텍쳐
>  전용 코드를 만드는 사람들과 READ_ONCE() 자체를 만드는 사람들 뿐임을 의미합니다.
>  그런 분들을 위해, 그리고 역사에 관심 있는 분들을 위해, 여기 데이터 의존성
> @@ -2714,144 +2714,6 @@ CPU 코어는 프로그램의 인과성이 유지된다고만 여겨진다면 
>  수도 있습니다.
>  
>  
> -캐시 일관성
> ------------
> -
> -하지만 삶은 앞에서 이야기한 것처럼 단순하지 않습니다: 캐시들은 일관적일 것으로
> -기대되지만, 그 일관성이 순서에도 적용될 거라는 보장은 없습니다.  한 CPU 에서
> -만들어진 변경 사항은 최종적으로는 시스템의 모든 CPU 에게 보여지게 되지만, 다른
> -CPU 들에게도 같은 순서로 보이게 될 거라는 보장은 없다는 뜻입니다.
> -
> -
> -두개의 CPU (1 & 2) 가 달려 있고, 각 CPU 에 두개의 데이터 캐시(CPU 1 은 A/B 를,
> -CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 다룬다고 생각해
> -봅시다:
> -
> -	            :
> -	            :                          +--------+
> -	            :      +---------+         |        |
> -	+--------+  : +--->| Cache A |<------->|        |
> -	|        |  : |    +---------+         |        |
> -	|  CPU 1 |<---+                        |        |
> -	|        |  : |    +---------+         |        |
> -	+--------+  : +--->| Cache B |<------->|        |
> -	            :      +---------+         |        |
> -	            :                          | Memory |
> -	            :      +---------+         | System |
> -	+--------+  : +--->| Cache C |<------->|        |
> -	|        |  : |    +---------+         |        |
> -	|  CPU 2 |<---+                        |        |
> -	|        |  : |    +---------+         |        |
> -	+--------+  : +--->| Cache D |<------->|        |
> -	            :      +---------+         |        |
> -	            :                          +--------+
> -	            :
> -
> -이 시스템이 다음과 같은 특성을 갖는다 생각해 봅시다:
> -
> - (*) 홀수번 캐시라인은 캐시 A, 캐시 C 또는 메모리에 위치할 수 있음;
> -
> - (*) 짝수번 캐시라인은 캐시 B, 캐시 D 또는 메모리에 위치할 수 있음;
> -
> - (*) CPU 코어가 한개의 캐시에 접근하는 동안, 다른 캐시는 - 더티 캐시라인을
> -     메모리에 내리거나 추측성 로드를 하거나 하기 위해 - 시스템의 다른 부분에
> -     액세스 하기 위해 버스를 사용할 수 있음;
> -
> - (*) 각 캐시는 시스템의 나머지 부분들과 일관성을 맞추기 위해 해당 캐시에
> -     적용되어야 할 오퍼레이션들의 큐를 가짐;
> -
> - (*) 이 일관성 큐는 캐시에 이미 존재하는 라인에 가해지는 평범한 로드에 의해서는
> -     비워지지 않는데, 큐의 오퍼레이션들이 이 로드의 결과에 영향을 끼칠 수 있다
> -     할지라도 그러함.
> -
> -이제, 첫번째 CPU 에서 두개의 쓰기 오퍼레이션을 만드는데, 해당 CPU 의 캐시에
> -요청된 순서로 오퍼레이션이 도달됨을 보장하기 위해 두 오퍼레이션 사이에 쓰기
> -배리어를 사용하는 상황을 상상해 봅시다:
> -
> -	CPU 1		CPU 2		COMMENT
> -	===============	===============	=======================================
> -					u == 0, v == 1 and p == &u, q == &u
> -	v = 2;
> -	smp_wmb();			v 의 변경이 p 의 변경 전에 보일 것을
> -					 분명히 함
> -	<A:modify v=2>			v 는 이제 캐시 A 에 독점적으로 존재함
> -	p = &v;
> -	<B:modify p=&v>			p 는 이제 캐시 B 에 독점적으로 존재함
> -
> -여기서의 쓰기 메모리 배리어는 CPU 1 의 캐시가 올바른 순서로 업데이트 된 것으로
> -시스템의 다른 CPU 들이 인지하게 만듭니다.  하지만, 이제 두번째 CPU 가 그 값들을
> -읽으려 하는 상황을 생각해 봅시다:
> -
> -	CPU 1		CPU 2		COMMENT
> -	===============	===============	=======================================
> -	...
> -			q = p;
> -			x = *q;
> -
> -위의 두개의 읽기 오퍼레이션은 예상된 순서로 일어나지 못할 수 있는데, 두번째 CPU
> -의 한 캐시에 다른 캐시 이벤트가 발생해 v 를 담고 있는 캐시라인의 해당 캐시에의
> -업데이트가 지연되는 사이, p 를 담고 있는 캐시라인은 두번째 CPU 의 다른 캐시에
> -업데이트 되어버렸을 수 있기 때문입니다.
> -
> -	CPU 1		CPU 2		COMMENT
> -	===============	===============	=======================================
> -					u == 0, v == 1 and p == &u, q == &u
> -	v = 2;
> -	smp_wmb();
> -	<A:modify v=2>	<C:busy>
> -			<C:queue v=2>
> -	p = &v;		q = p;
> -			<D:request p>
> -	<B:modify p=&v>	<D:commit p=&v>
> -			<D:read p>
> -			x = *q;
> -			<C:read *q>	캐시에 업데이트 되기 전의 v 를 읽음
> -			<C:unbusy>
> -			<C:commit v=2>
> -
> -기본적으로, 두개의 캐시라인 모두 CPU 2 에 최종적으로는 업데이트 될 것이지만,
> -별도의 개입 없이는, 업데이트의 순서가 CPU 1 에서 만들어진 순서와 동일할
> -것이라는 보장이 없습니다.
> -
> -
> -여기에 개입하기 위해선, 데이터 의존성 배리어나 읽기 배리어를 로드 오퍼레이션들
> -사이에 넣어야 합니다 (v4.15 부터는 READ_ONCE() 매크로에 의해 무조건적으로
> -그렇게 됩니다).  이렇게 함으로써 캐시가 다음 요청을 처리하기 전에 일관성 큐를
> -처리하도록 강제하게 됩니다.
> -
> -	CPU 1		CPU 2		COMMENT
> -	===============	===============	=======================================
> -					u == 0, v == 1 and p == &u, q == &u
> -	v = 2;
> -	smp_wmb();
> -	<A:modify v=2>	<C:busy>
> -			<C:queue v=2>
> -	p = &v;		q = p;
> -			<D:request p>
> -	<B:modify p=&v>	<D:commit p=&v>
> -			<D:read p>
> -			smp_read_barrier_depends()
> -			<C:unbusy>
> -			<C:commit v=2>
> -			x = *q;
> -			<C:read *q>	캐시에 업데이트 된 v 를 읽음
> -
> -
> -이런 부류의 문제는 DEC Alpha 계열 프로세서들에서 발견될 수 있는데, 이들은
> -데이터 버스를 좀 더 잘 사용해 성능을 개선할 수 있는, 분할된 캐시를 가지고 있기
> -때문입니다.  대부분의 CPU 는 하나의 읽기 오퍼레이션의 메모리 액세스가 다른 읽기
> -오퍼레이션에 의존적이라면 데이터 의존성 배리어를 내포시킵니다만, 모두가 그런건
> -아니기 때문에 이점에 의존해선 안됩니다.
> -
> -다른 CPU 들도 분할된 캐시를 가지고 있을 수 있지만, 그런 CPU 들은 평범한 메모리
> -액세스를 위해서도 이 분할된 캐시들 사이의 조정을 해야만 합니다.  Alpha 는 가장
> -약한 메모리 순서 시맨틱 (semantic) 을 선택함으로써 메모리 배리어가 명시적으로
> -사용되지 않았을 때에는 그런 조정이 필요하지 않게 했으며, 이는 Alpha 가 당시에
> -더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, (다시 말하건대, v4.15
> -이후부터는) Alpha 아키텍쳐 전용 코드와 READ_ONCE() 매크로 내부에서를 제외하고는
> -smp_read_barrier_depends() 가 사용되지 않아야 함을 알아두시기 바랍니다.
> -
> -
>  캐시 일관성 VS DMA
>  ------------------
>  
> @@ -3012,10 +2874,8 @@ Alpha CPU 의 일부 버전은 분할된 데이터 캐시를 가지고 있어서
>  데이터의 발견을 올바른 순서로 일어나게 하기 때문입니다.
>  
>  리눅스 커널의 메모리 배리어 모델은 Alpha 에 기초해서 정의되었습니다만, v4.15
> -부터는 리눅스 커널이 READ_ONCE() 내에 smp_read_barrier_depends() 를 추가해서
> -Alpha 의 메모리 모델로의 영향력이 크게 줄어들긴 했습니다.
> -
> -위의 "캐시 일관성" 서브섹션을 참고하세요.
> +부터는 Alpha 용 READ_ONCE() 코드 내에 smp_mb() 가 추가되어서 메모리 모델로의
> +Alpha 의 영향력이 크게 줄어들었습니다.
>  
>  
>  가상 머신 게스트
> -- 
> 2.17.2
> 
